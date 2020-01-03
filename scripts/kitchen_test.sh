#!/bin/bash

set -oe

VAGRANT_VERSION='2.2.6'
VBOX_VERSION='6.1'

function kitchen_test {
  echo "Starting Test Kitchen"

  apt-get update -y && \
    apt-get install -y build-essential unzip wget

  # Install Vagrant
  wget -O /tmp/vagrant_${VAGRANT_VERSION}_linux_amd64.zip \
    https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_linux_amd64.zip && \
    unzip /tmp/vagrant_${VAGRANT_VERSION}_linux_amd64.zip \
    -d /usr/bin/

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