#!/bin/sh
echo "Making *.ingress.cluster.local accessible to pods through the ingress controller"

DIR=`dirname $0`

kubectl apply -f $DIR/ingress-controller-service.yaml

mkdir -p $DIR/tmp
kubectl get configmap coredns -n kube-system -o=yaml | \
    sed $'s/ready/ready\\\n        rewrite name regex (.*)\\\\.ingress\\\\.local ingress-controller.kube-system.svc.cluster.local/g' \
    > $DIR/tmp/coredns.yml

kubectl apply -f $DIR/tmp/coredns.yml
rm -rf $DIR/tmp
