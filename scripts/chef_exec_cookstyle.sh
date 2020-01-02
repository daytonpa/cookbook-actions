#!/bin/bash

set -oe

function chef_exec_cookstyle {
  echo "Performing Chef Cookstyle linting checks"

  local command_output=$(chef exec cookstyle -D ${*} 2>&1)
  local command_exit_code=${?}

  if [[ ${command_exit_code} -eq 0 ]]; then
    echo
    echo "Chef Cookstyle checks passed ✔"
    echo
  else
    echo
    echo "Chef Cookstyle checks encountered issues ✘"
    echo
  fi
  echo "${command_output}"
  exit ${command_exit_code}
}