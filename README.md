# Monitoring Microservices application using OpenTelemetry

Reference Documentation: https://opentelemetry.io/docs/

- https://opentelemetry.io/docs/demo/kubernetes-deployment/

# Deploy All Components

To deploy all components (Microservices Application, OpenTelemetry Collector, Jaeger, Prometheus, and Grafana) at once, run:

    ./deploy.sh

Alternatively, you can use the following kubectl command:

    kubectl apply -f ./opentelemetry-app -f ./opentelemetry-collector -f ./jaeger -f ./prometheus -f ./grafana

## Port Forwarding

You can port-forward to access the application UIs

```bash
k port-forward svc/opentelemetry-demo-frontendproxy 8080:8080
```

```bash
k port-forward svc/opentelemetry-demo-prometheus-server 9090:9090
```
