#!/usr/bin/env bash
set -e

./prepare.sh
helmfile apply
