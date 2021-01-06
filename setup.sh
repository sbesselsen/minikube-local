#!/usr/bin/env bash
set -e

DIR=$(dirname "$0")
if [ ! -f "$DIR/values.yaml" ]; then
    echo "First create a values.yaml from the template in values.tpl.yaml."
    exit 1
fi

./prepare.sh
helmfile apply
