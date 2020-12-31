#!/usr/bin/env bash
DIR=$(dirname "$0")
if [ ! -f "$DIR/values.yaml" ]; then
    echo "First create a values.yaml from the template in values.tpl.yaml."
    exit 1
fi

echo "About to run delete ConfigMap kube-system/coredns on cluster $(kubectl config current-context)."
echo "It will be recreated when running helmfile apply."
read -p "Enter to continue, Ctrl+C to cancel..."
kubectl delete configmap coredns -n kube-system
