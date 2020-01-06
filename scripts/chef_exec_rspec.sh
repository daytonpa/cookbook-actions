#!/bin/bash

set -oe

function chef_exec_rspec {
  echo "Performing unit tests with ChefSpec"

  CHEF_LICENSE=accept chef exec rspec -fd ${*}
  if [[ ${?} -eq 0 ]]; then
    echo
    echo "ChefSpec unit tests passed ✔"
    echo
  else
    echo
    echo "ChefSpec unit tests encountered issues ✘"
    echo
    exit 1
  fi
}