#!/usr/bin/env bash
DOCKER_IP="127.0.0.1"

OLD_HOSTNAMES=$(grep "\.local" /etc/hosts | awk '{ print $2 }' | sort)
NEW_HOSTNAMES=$(kubectl get ingresses --all-namespaces --context=docker-desktop -o=json | jq -r '.items | map(.spec.rules) | flatten | map(.host)[]' | sort)

ADDED_HOSTNAMES=$(comm -13 <(echo $OLD_HOSTNAMES | tr ' ' '\n') <(echo $NEW_HOSTNAMES | tr ' ' '\n'))
REMOVED_HOSTNAMES=$(comm -23 <(echo $OLD_HOSTNAMES | tr ' ' '\n') <(echo $NEW_HOSTNAMES | tr ' ' '\n'))

for HOSTNAME in $ADDED_HOSTNAMES; do
    sudo hostile set $DOCKER_IP $HOSTNAME
done

for HOSTNAME in $REMOVED_HOSTNAMES; do
    sudo hostile remove $HOSTNAME
done
