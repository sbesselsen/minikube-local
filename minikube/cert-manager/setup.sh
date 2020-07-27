#!/usr/bin/env bash
#kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.16.0/cert-manager.yaml

DIR=`dirname $0`
if [ -f $DIR/data/ca.pem ]; then
    cat <<- EOF > $DIR/data/ca-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: ca-key-pair
  namespace: cert-manager
data:
  tls.crt: $(cat $DIR/data/ca.pem | base64)
  tls.key: $(cat $DIR/data/ca.key | base64)
EOF
    kubectl apply -f $DIR/data/ca-secret.yaml
    kubectl apply -f $DIR/ca-cluster-issuer.yaml
else
    echo "No certificate available"
    exit 1
fi
