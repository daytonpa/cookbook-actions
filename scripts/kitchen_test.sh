#!/bin/bash

set -oe

function kitchen_test {
  echo "Starting Test Kitchen"

  local command_output=$(kitchen test 2>&1)
  local command_exit_code=${?}

  if [[ ${command_exit_code} -eq 0 ]]; then
    echo
    echo "Test Kitchen successfully completed ✔"
    echo
  else
    echo
    echo "Test Kitchen encountered issues ✘"
    echo
  fi
  echo "${command_output}"
  exit ${command_exit_code}
}