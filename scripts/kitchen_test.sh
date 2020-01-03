#!/bin/bash

set -oe

VAGRANT_VERSION='2.2.6'
VBOX_VERSION='6.1'

function kitchen_test {
  echo "Starting Test Kitchen"

  apt-get update -y && apt-get install -y lsb-core unzip wget

  # Install Vagrant
  wget -O /tmp/vagrant_${VAGRANT_VERSION}_linux_amd64.zip \
    https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_linux_amd64.zip && \
    unzip /tmp/vagrant_${VAGRANT_VERSION}_linux_amd64.zip \
    -d /usr/bin/

  /usr/bin/vagrant --version

  # Install VirtualBox
  echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | tee -a /etc/apt/sources.list

  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add - & \
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add - & \
    wait

  apt-get update -y && \
    apt-get install virtualbox-${VBOX_VERSION}

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