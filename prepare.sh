#!/usr/bin/env bash
echo "About to annotate and label ConfigMap kube-system/coredns on cluster $(kubectl config current-context)."
read -p "Enter to continue, Ctrl+C to cancel..."
kubectl annotate configmap coredns -n kube-system --overwrite meta.helm.sh/release-name=coredns-patches
kubectl annotate configmap coredns -n kube-system --overwrite meta.helm.sh/release-namespace=kube-system
kubectl label configmap coredns -n kube-system --overwrite app.kubernetes.io/managed-by=Helm
