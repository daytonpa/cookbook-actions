#!/bin/bash

set -oe

function chef_exec_cookstyle {
  echo "Performing Chef Cookstyle linting checks"

  chef exec cookstyle -D ${*}
  if [[ ${?} -eq 0 ]]; then
    echo
    echo "Chef Cookstyle checks passed ✔"
    echo
  else
    echo
    echo "Chef Cookstyle checks encountered issues ✘"
    echo
    exit 1
  fi
}