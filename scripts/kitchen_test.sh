#!/bin/bash

set -oe

function kitchen_test {
  echo "Starting Test Kitchen"

  kitchen test
  if [[ ${command_exit_code} -eq 0 ]]; then
    echo
    echo "Test Kitchen successfully completed ✔"
    echo
  else
    echo
    echo "Test Kitchen encountered issues ✘"
    echo
  fi
}