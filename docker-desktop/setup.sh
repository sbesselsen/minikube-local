#!/bin/sh
echo "Deploying ingress-nginx"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.42.0/deploy/static/provider/cloud/deploy.yaml

echo "Waiting..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=ingress-nginx,app.kubernetes.io/component=controller -n ingress-nginx --timeout=90s

echo "Done"
