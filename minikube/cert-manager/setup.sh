#!/usr/bin/env bash
echo "Installing cert-manager..."
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.16.0/cert-manager.yaml

# Wait until it's ready.
echo "Waiting until cert-manager is ready..."
kubectl wait --for=condition=ready pod -l app=webhook -n cert-manager --timeout=90s

DIR=`dirname $0`


if [ ! -f $DIR/tmp/ca.pem ]; then
    echo "No CA available. Generating one now."
    $DIR/generate-ca.sh
fi

cat <<- EOF > $DIR/tmp/ca-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: ca-key-pair
  namespace: cert-manager
data:
  tls.crt: $(cat $DIR/tmp/ca.pem | base64)
  tls.key: $(cat $DIR/tmp/ca.key | base64)
EOF

kubectl apply -f $DIR/tmp/ca-secret.yaml
sleep 5
kubectl apply -f $DIR/ca-cluster-issuer.yaml
rm -rf $DIR/tmp
