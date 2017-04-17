#!/bin/bash

declare -r changed=$(git diff --name-only HEAD~1)

echo ${changed}

if [[ "app-config.yml" == ${changed} ]]
then
  echo "Gonna reconfigure the application"
fi


