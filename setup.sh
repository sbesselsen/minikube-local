#!/bin/sh
kind create cluster --config=./cluster-config.yaml

for module in $(ls modules/); do
    echo "🌈 $module"
    modules/$module/install.sh
    echo ""
done
