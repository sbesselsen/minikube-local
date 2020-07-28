#!/bin/sh
MINIKUBE_IP=$(minikube ip)
for HOSTNAME in $(grep 192.168.64. /etc/hosts | awk '{ print $2 }'); do
    echo "sudo hostile set $MINIKUBE_IP $HOSTNAME"
    sudo hostile set $MINIKUBE_IP $HOSTNAME
done
