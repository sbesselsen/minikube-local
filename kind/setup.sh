#!/bin/sh
realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")"
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")"
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD"
  echo "$REALPATH"
}

LOCAL_DIR=$(dirname $0)
ABS_LOCAL_DIR=$(realpath $LOCAL_DIR)

kind delete cluster

cat $LOCAL_DIR/cluster-config.yaml | sed s@%DIR%@$ABS_LOCAL_DIR@g > $LOCAL_DIR/.cluster-config.yaml
kind create cluster --config=$ABS_LOCAL_DIR/.cluster-config.yaml
rm $LOCAL_DIR/.cluster-config.yaml

for module in $(ls modules/); do
    echo "🌈 $module"
    if [ -f modules/$module/install.sh ]; then
        modules/$module/install.sh
        echo ""
    else
        echo "Skipping"
    fi
done
