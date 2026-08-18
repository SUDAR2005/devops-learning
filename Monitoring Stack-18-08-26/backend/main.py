import time

from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware import cors
from fastapi.responses import FileResponse, Response

import redis
from prometheus_client import Counter, Histogram, Gauge, generate_latest, CONTENT_TYPE_LATEST

app = FastAPI()

app.add_middleware(
    cors.CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=False
)

REQUEST_COUNT = Counter(
    "http_requests_total",
    "Total number of HTTP requests",
    ["method", "path", "status_code"]
)

REQUEST_LATENCY = Histogram(
    "http_request_duration_seconds",
    "HTTP request latency in seconds",
    ["method", "path"]
)

COUNTER_VALUE = Gauge(
    "app_counter_value",
    "Current value of the redis-backed counter"
)

@app.middleware("http")
async def prometheus_middleware(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)
    duration = time.time() - start_time

    path = request.url.path
    REQUEST_LATENCY.labels(method=request.method, path=path).observe(duration)
    REQUEST_COUNT.labels(
        method=request.method,
        path=path,
        status_code=response.status_code
    ).inc()

    return response

@app.get("/metrics")
async def metrics():
    return Response(generate_latest(), media_type=CONTENT_TYPE_LATEST)

# redis cache for storage (acts as db)
cache = redis.Redis(host='db', port=6379, decode_responses=True)

@app.post("/dec-count")
async def decrement_count():
    try:
        count = cache.get("count")
        if count is None:
            raise HTTPException(status_code=404, detail="Count not found")
        new_count = int(count) - 1

        cache.set("count", new_count)
        COUNTER_VALUE.set(new_count)
        return {"count": new_count}
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/inc-count")
async def increment_count():
    try:
        count = cache.get("count")
        if count is None:
            cache.set("count", 1)
            COUNTER_VALUE.set(1)
            return {"count": 1}

        new_count = int(count) + 1
        cache.set("count", new_count)
        COUNTER_VALUE.set(new_count)
        return {"count": new_count}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))