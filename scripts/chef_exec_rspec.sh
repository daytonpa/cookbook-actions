#!/bin/bash

set -oe

function chef_exec_rspec {
  echo "Performing unit tests with ChefSpec"

  local command_output=$(chef exec rspec -fd ${*} 2>&1)
  local command_exit_code=${?}

  if [[ ${command_exit_code} -eq 0 ]]; then
    echo
    echo "ChefSpec unit tests passed ✔"
    echo
  else
    echo
    echo "ChefSpec unit tests encountered issues ✘"
    echo
  fi
  echo "${command_output}"
  exit ${command_exit_code}
}