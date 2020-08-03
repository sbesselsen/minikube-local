#!/usr/bin/env bash
MINIKUBE_IP=$(minikube ip 2>/dev/null)
if [ -z $MINIKUBE_IP ]; then
    echo "No minikube ip."
    exit 1
fi

echo "" | sed -r 's//' > /dev/null 2>&1
if [ $? -eq 0 ]; then
    # Linux
    MINIKUBE_RANGE=$(echo $MINIKUBE_IP | sed -r 's/[0-9]+$//g')
else
    # Mac
    MINIKUBE_RANGE=$(echo $MINIKUBE_IP | sed -E 's/[0-9]+$//g')
fi

OLD_HOSTNAMES=$(grep $MINIKUBE_RANGE /etc/hosts | awk '{ print $2 }' | sort)
NEW_HOSTNAMES=$(kubectl get ingresses --all-namespaces --context=minikube -o=json | jq -r '.items | map(.spec.rules) | flatten | map(.host)[]' | sort)

ADDED_HOSTNAMES=$(comm -13 <(echo $OLD_HOSTNAMES | tr ' ' '\n') <(echo $NEW_HOSTNAMES | tr ' ' '\n'))
REMOVED_HOSTNAMES=$(comm -23 <(echo $OLD_HOSTNAMES | tr ' ' '\n') <(echo $NEW_HOSTNAMES | tr ' ' '\n'))

for HOSTNAME in $ADDED_HOSTNAMES; do
    sudo hostile set $MINIKUBE_IP $HOSTNAME
done

for HOSTNAME in $REMOVED_HOSTNAMES; do
    sudo hostile remove $HOSTNAME
done
