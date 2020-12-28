#!/bin/sh
echo "Making *.ingress.cluster.local accessible to pods through the ingress controller"

DIR=`dirname $0`

kubectl apply -f $DIR/ingress-controller-service.yaml
kubectl apply -f $DIR/coredns.yaml
