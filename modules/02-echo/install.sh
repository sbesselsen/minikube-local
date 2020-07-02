#!/bin/sh
DIR=`dirname $0`
kubectl apply -f $DIR/echo.yaml
