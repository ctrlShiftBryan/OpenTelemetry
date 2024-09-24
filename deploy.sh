#!/bin/bash

echo "Deploying all components..."
kubectl apply -f ./opentelemetry-app -f ./opentelemetry-collector -f ./jaeger -f ./prometheus -f ./grafana

echo "Deployment complete. Check the status of your pods with 'kubectl get pods'"
