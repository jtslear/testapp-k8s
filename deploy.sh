#!/bin/bash

declare -r changed=$(git diff --name-only HEAD~1)

echo ${changed}

containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

if [[ $(containsElement "app-config.yml" "${changed}") ]]
then
  echo "Gonna reconfigure the application"
else
  echo "No application configuration changes detected"
fi


