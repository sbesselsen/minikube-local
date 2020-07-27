#!/usr/bin/env bash
minikube start --cpus=4 --memory=8g --vm=true
minikube addons enable ingress
minikube addons enable metrics-server

# Certmanager
cert-manager/setup.sh
