#!/bin/bash

declare -r environment=$1

kubectl set --namespace production image deployments/testapp testapp=quay.io/waffleio/testapp-k8s:${CIRCLE_SHA1}
kubectl rollout status deployments/testapp --namespace ${environment}

if [[ $? != 0 ]]
then
  echo "The deploy has failed, I'm going to attempt to roll back..."
  kubectl rollout undo deployments/testapp --namespace ${environment}
  kubectl rollout status deployments/testapp --namespace ${environment}
  if [[ $? != 0 ]]
  then
    echo "Rollback was successful."
  fi

  # Tell circle that we failed
  exit 1
else
  echo "Deployment has succeeded."
fi
