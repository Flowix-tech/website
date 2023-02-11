#!/usr/bin/bash

if [[ -z "$APP_NAME" ]]; then
  echo "Must set APP_NAME environmental variable"
  exit 1
fi

command kubectl -n flowix get deployment $APP_NAME &> /dev/null
if [ $? -eq 0 ]
then
  command kubectl rollout restart -n flowix deployment/$APP_NAME
else
  source ./scripts/generate_manifests.sh
  command kubectl apply -k ./kubernetes/
fi

