#!/bin/bash

echo "Cleaning up Kubernetes resources..."

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
