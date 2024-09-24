# Monitoring Microservices application using OpenTelemetry

Reference Documentation: https://opentelemetry.io/docs/

- https://opentelemetry.io/docs/demo/kubernetes-deployment/

# 0. Create new namespace

    kubectl create namespace otel-demo

# 1. Install Elasticsearch on Minikube Cluster:

    <!-- kubectl apply -f ./elasticsearch -->

# 2. Install Kibana on Minikube Cluster:

    <!-- kubectl apply -f ./kibana -->

# 3. Install Fluentd on Minikube Cluster:

    <!-- kubectl apply -f ./kibana -->

# 3. Validate the EFK Cluster (optional)

<!-- Run one pod in the same namespace to capture the logs on cluster

    kubectl run nginx --image=nginx --restart=Never
    kubectl run mycurlpod --image=curlimages/curl -i --tty -- sh -->

# 4. Install and Configure Microservices Application:

    kubectl apply -f ./opentelemetry-app

# 5. Install and Configure Open Telemetry Collector:

This will collect traces from application and captures at the collector port.
kubectl apply -f ./opentelemetry-collector

# 6. Install and Configure Jaeger:

kubectl apply -f ./jaeger

# 7. Install and Configure Prometheus:

kubectl apply -f ./prometheus

# 8. Install and Configure Grafana:

kubectl apply -f ./grafana

## portforwarding

You can portforward to access the application UIs

```bash
k port-forward svc/opentelemetry-demo-frontendproxy 8080:8080
```

```bash
k port-forward svc/opentelemetry-demo-prometheus-server 9090:9090
```
