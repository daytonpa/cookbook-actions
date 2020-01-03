#!/bin/bash

set -ou

### VARIABLES ###
#
# EXTRA PACKAGES
EXTRA_PACKAGES=( ca-certificates jq vim wget )

function has_prefix {
  case ${2} in
    "${1}"*)
      true
      ;;
    *)
      false
      ;;
  esac
}

function parse_inputs {
  # REQUIRED
  if [[ "${INPUT_CHEF_ACTIONS_SUBCOMMAND}" != '' ]]; then
    chef_subcommand=${INPUT_CHEF_ACTIONS_SUBCOMMAND}
  else
    echo "ERROR: Input chef_actions_subcommand cannot be empty"
    exit 1
  fi

  # OPTIONAL
  workspace='.'
  if [[ "${INPUT_CHEF_ACTIONS_WORKSPACE}" != '' ]] || [[ "${INPUT_CHEF_ACTIONS_WORKSPACE}" != '.' ]]; then
    echo "INFO: Workspace is being changed from the default setting to ${INPUT_CHEF_ACTIONS_WORKSPACE}"
    workspace="${INPUT_CHEF_ACTIONS_WORKSPACE}"
  else
    echo "INFO: Workspace has not been set.  Using default setting"
  fi

}

function pre_run {
  apt update -y && \
    apt install -y \
    ${EXTRA_PACKAGES[@]}
}

function main {
  local scripts_directory="$(dirname ${0})/scripts"
  local scripts_arr=($(ls -d ${scripts_directory}/*))

  # Load our scripts
  for script in scripts_arr; do
    source ${scripts_directory}/${script}.sh
  done

  cd ${GITHUB_WORKSPACE}/${workspace}
  case "${chef_subcommand}" in
    lint)
      chef_exec_cookstyle ${*}
      chef_exec_foodcritic ${*}
      ;;
    unit)
      chef_exec_rspec ${*}
      ;;
    kitchen)
      kitchen_test
      ;;
    *)
      echo "ERROR: You must provide a valid value for 'chef_subcommand'"
      exit 1
      ;;
  esac
}

pre_run && main "${*}"
