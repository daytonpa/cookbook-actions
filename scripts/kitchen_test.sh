#!/bin/bash

set -oe

VAGRANT_VERSION='2.2.6'
VBOX_VERSION='6.1'

function kitchen_test {
  echo "Starting Test Kitchen"

  apt-get update -y && \
    apt-get install -y build-essential

  chef exec gem install vagrant
  chef exec gem install virtualbox

  kitchen test
  if [[ ${?} -eq 0 ]]; then
    echo
    echo "Test Kitchen successfully completed ✔"
    echo
  else
    echo
    echo "Test Kitchen encountered issues ✘"
    echo
  fi
}