from fastapi import FastAPI, HTTPException
from fastapi.middleware import cors
from fastapi.responses import FileResponse

import redis

app = FastAPI()

app.add_middleware(
    cors.CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=False
)

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
        return {"count": new_count}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/inc-count")
async def increment_count():
    try: 
        count = cache.get("count")
        if count is None:
            cache.set("count", 1)
            return {"count": 1}
         
        new_count = int(count) + 1
        cache.set("count", new_count)
        return {"count": new_count} 
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))