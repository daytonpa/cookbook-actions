#!/bin/bash

set -ou

function main {
  local scripts_directory="$(dirname ${0})/scripts"
  local scripts=( chef_exec_cookstyle chef_exec_foodcritic chef_exec_rspec )
  for script in scripts; do
    source ${scripts_directory}/${script}.sh
  done
}

main