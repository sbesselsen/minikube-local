#!/usr/bin/env bash
DIR=`dirname $0`

minikube start \
    --cpus=4 \
    --memory=8g \
    --vm=true \
    --disk-size=60g
minikube addons enable ingress
minikube addons enable metrics-server

# Certmanager
$DIR/cert-manager/setup.sh

# Other resources
kubectl apply -f $DIR/resources/

minikube dashboard
