#!/bin/bash -x

declare -r changed=$(git diff --name-only HEAD~1)

echo ${changed}

containsElement () {
  local e
  for e in "${@:2}"
  do
    if [[ ${e} == ${1} ]]
    then
      return 0
    fi
  done
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


