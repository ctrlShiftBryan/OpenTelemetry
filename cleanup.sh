#!/bin/bash

echo "Cleaning up Kubernetes resources..."

# Remove Elasticsearch resources
echo "Removing Elasticsearch resources..."
kubectl delete -f elasticsearch/


# Remove Fluentd resources
echo "Removing Fluentd resources..."
kubectl delete -f fluentd/


# Remove Kibana resources
echo "Removing Kibana resources..."
kubectl delete -f kibana/

# Remove Grafana resources
echo "Removing Grafana resources..."
kubectl delete -f grafana/

# Remove Prometheus resources
echo "Removing Prometheus resources..."
kubectl delete -f prometheus/

# Remove Jaeger resources
echo "Removing Jaeger resources..."
kubectl delete -f jaeger/

# Remove OpenTelemetry Collector resources
echo "Removing OpenTelemetry Collector resources..."
kubectl delete -f opentelemetry-collector/

# Remove Microservices Application resources
echo "Removing Microservices Application resources..."
kubectl delete -f opentelemetry-app/
