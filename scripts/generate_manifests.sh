#!/usr/bin/env bash
set -euo pipefail

# Check if REGISTRY_URL is set
if [ -z "${REGISTRY_URL:-}" ];then
  echo "REGISTRY_URL is not set"
  exit 1
fi

# Check if APP_URL is set
if [ -z "${APP_URL:-}" ];then
  echo "APP_URL is not set"
  exit 1
fi


export REGISTRY_URL
export APP_URL
BASE_DIR="$(pwd)"

# Generate secret from env variables
kubectl create configmap -n flowix  flowix-website-config \
  --from-literal=$(echo "APP_URL=$APP_URL")  \
  --from-literal=$(echo "APP_IMAGE=$REGISTRY_URL/website:latest") \
  --dry-run=client -o yaml > $BASE_DIR/kubernetes/config.yml

#envsubst < $BASE_DIR/scripts/kustomization.envsubst.yml > $BASE_DIR/kubernetes/kustomization.yml
#command kubectl kustomize ./kubernetes