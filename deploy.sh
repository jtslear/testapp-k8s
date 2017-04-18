#!/bin/bash -x

declare -r image=jtslear/testapp-k8s
declare -r deployment=testapp

declare -a files_changed=($(git diff --name-only HEAD~1))

echo ${files_changed}

elementIn () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

elementIn "kubernetes/" "${files_changed[@]}"
declare -r config_is_changed=$?
echo ${config_is_changed}

if [[ ${config_is_changed} -eq 0 ]]
then
  echo "Gonna reconfigure the application"
  kubectl create -f ./kubernetes/
else
  echo "No application configuration changes detected"
  echo "Proceeding to complete a deploy..."
  kubectl set image deployments/${deployment} ${image}=${image}:${CIRCLE_SHA1}
fi


