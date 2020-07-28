#!/bin/sh
MINIKUBE_IP=$(minikube ip)

echo "" | sed -r 's//' > /dev/null 2>&1
if [ $? -eq 0 ]; then
    # Linux
    MINIKUBE_RANGE=$(echo $MINIKUBE_IP | sed -r 's/[0-9]+$//g')
else
    # Mac
    MINIKUBE_RANGE=$(echo $MINIKUBE_IP | sed -E 's/[0-9]+$//g')
fi
for HOSTNAME in $(grep $MINIKUBE_RANGE /etc/hosts | awk '{ print $2 }'); do
    echo "sudo hostile set $MINIKUBE_IP $HOSTNAME"
    sudo hostile set $MINIKUBE_IP $HOSTNAME
done
