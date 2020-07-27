#!/bin/sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
echo ""
if kubectl get pods -n ingress-nginx | grep ingress-nginx-controller | grep Running > /dev/null; then
    echo "Ingress controller already online"
else
    REAL_ECHO=`which echo`
    $REAL_ECHO -n "Waiting for Ingress controller to come online..."

    until kubectl get pods -n ingress-nginx | grep ingress-nginx-controller | grep Running > /dev/null; do
        $REAL_ECHO -n "."
        sleep 1
    done

    echo ""
    echo "Waiting just a little bit longer..."
    sleep 20
fi
