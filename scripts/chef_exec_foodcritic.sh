#!/bin/bash

set -oe

function chef_exec_foodcritic {
  echo "Performing Chef Foodritic linting checks"

  chef exec foodcritic ${*}
  if [[ ${?} -eq 0 ]]; then
    echo
    echo "Chef Foodcritic checks passed ✔"
    echo
  else
    echo
    echo "Chef Foodcritic checks encountered issues ✘"
    echo
    exit 1
  fi
}