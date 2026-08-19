 # Monitoring Stack

This ReadMe provides my observation on monitoring stack for a simple containerized application.

## Components

- **Prometheus** – collects and stores time-series metrics.
- **Grafana** – provides dashboards and visualization.
- **Node Exporter** – exposes host system metrics.
- **cadvisor** – exposes container metrics.

## File Structure

```
|-- backend
|   |-- DockerFile          # docker file for backend service
|   |-- main.yml
|   |-- requirements.txt    # python dependencies
|-- frontend
|   |-- DockerFile      # docker file for frontend service
|   |-- index.html      # frontend html file
|-- k8s
|   |-- backend.yml     # backend kubernetes deployment and service
|   |-- frontend.yml    # frontend kubernetes deployment and service
|   |-- ingress.yml     # ingress controller for routing traffic to frontend and backend
|   |-- node-exporter.yml # node exporter for pod level  metrics
|   |-- redis.yml       # DB service (accessed through backend not with ingress)
|-- monitoring
|   |-- grafana-deployment.yml   # Grafana deployment and service (also contains grafana PVC)
|   |-- grafana-ds.yml        # Config Map for Grafana data source
|   |-- prometheus-deployment.yml # Prometheus deployment and service
|   |-- prometheus-config.yml   # Config map for Prometheus configuration
|   |-- prometheus-rbac.yml    # Role Based Access Control for Prometheus (service account, role, and role binding)
|   |-- rules.yml   # Prometheus alerting rules 
|   |-- vpa-policy.yml # Vertical Pod Autoscaler policy for backend-service pods
|-- ReadMe.md
```

## Apply the Manifests

```
kubectl apply -f k8s/
kubectl apply -f monitoring/

kubectl get events -w --field-selector type=Warning  # check error status in  created objects
```

## Screenshots - Output

- Prometheus Web UI - configured as Cluster IP so accessing with port forwarding
```
kubectl port-forward svc/prometheus-service <host-network-port>:9090(prometheus-service port)
``` 
-- target endpoints (as mentioned in prometheus-config.yml)
![alt text](<monitoring-stack screen shots/prometheus-1.png>)
-- Alerts (as mentioned in rules.yml)
![alt text](./monitoring-stack%20screen%20shots/prometheus-2.png)


- Grafana - as it is configured with node-port service can access through minikube-ip
```
minikube service grafana-service
```
-- Grafana Dashboard
![alt text](./monitoring-stack%20screen%20shots/image.png)

-- Alert Synced from prometheus to Grafana
![alt text](./monitoring-stack%20screen%20shots/alert.png)



- Vertical Pod Autoscaler (VPA)

```
kubectl describe vpa backend-vpa        # check VPA status and recommendations
```
-- The pod failed to initialize due to insufficient resources, and VPA recommended increasing the CPU and memory limits. After applying the recommended changes, the pod was able to start successfully.
![alt text](<monitoring-stack screen shots/vpa-1.png>)

-- Actual Mmeory in `backend.yml` is `10Mi` but VPA recommended `42Mi` and after applying the changes the pod started successfully.
![alt text](<monitoring-stack screen shots/vpa-2.png>)

-- The recommendation from VPA is based on the resource usage of the pod over time. It analyzes the historical data and provides recommendations for CPU and memory limits that would allow the pod to run efficiently without being throttled or evicted. In this case, the VPA recommended increasing the memory limit from `10Mi` to `42Mi`, which allowed the pod to start successfully and run without issues.

![alt text](<monitoring-stack screen shots/vpa-3.png>)