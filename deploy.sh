#!/bin/bash -x

declare -a changed=($(git diff --name-only HEAD~1))

echo ${changed}

containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

containsElement "app-config.yml" "${changed[@]}"
declare -r is_changed=$?
echo ${is_changed}

if [[ ${is_changed} -eq 0 ]]
then
  echo "Gonna reconfigure the application"
else
  echo "No application configuration changes detected"
fi


