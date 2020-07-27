#!/bin/sh
if which helm > /dev/null; then
    if kubectl get namespace prometheus > /dev/null; then
        echo "Prometheus already installed"
    else
        kubectl create namespace prometheus
        helm install prometheus stable/prometheus -n prometheus
    fi
else
    echo "❗️ Helm is not installed!"
fi
