#!/bin/bash

set -oe

function chef_exec_foodcritic {
  echo "Performing Chef Foodritic linting checks"

  local command_output=$(chef exec foodcritic ${*} 2>&1)
  local command_exit_code=${?}

  if [[ ${command_exit_code} -eq 0 ]]; then
    echo
    echo "Chef Foodcritic checks passed ✔"
    echo
  else
    echo
    echo "Chef Foodcritic checks encountered issues ✘"
    echo
  fi
  echo "${command_output}"
  exit ${command_exit_code}
}