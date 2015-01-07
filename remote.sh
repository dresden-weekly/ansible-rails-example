#!/bin/bash
# This script should be placed in the root of your project

#   Absolute path of the project
PROJECT_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#   Relative path of vagrant-ansible-remote to the project
VAGRANT_ANSIBLE_REMOTE=vagrant-ansible-remote

#   Vagrant name of the machine with Ansible
VAGRANT_ANSIBLE_MACHINE=${VAGRANT_ANSIBLE_MACHINE:=ansible-vm}

#   default relative hosts file, overriden by parameters
ANSIBLE_HOSTS_NAME=${ANSIBLE_HOSTS_NAME:=itedd-vm}

#   transfer some environment variables
if [ ! -z $REPO_USER ] && [ "${ANSIBLE_ENV/REPO_USER/}" == "$ANSIBLE_ENV" ]; then
  ANSIBLE_ENV="REPO_USER=$REPO_USER $ANSIBLE_ENV"
fi
if [ ! -z $REPO_PASSWORD ] && [ "${ANSIBLE_ENV/REPO_PASSWORD/}" == "$ANSIBLE_ENV" ]; then
  ANSIBLE_ENV="REPO_PASSWORD=$REPO_PASSWORD $ANSIBLE_ENV"
fi
if [ ! -z $SECRET_KEY_BASE ] && [ "%{ANSIBLE_ENV/SECRET_KEY_BASE/}" == "$ANSIBLE_ENV" ]; then
  ANSIBLE_ENV="SECRET_KEY_BASE=$SECRET_KEY_BASE $ANSIBLE_ENV"
fi

source "$PROJECT_FOLDER/$VAGRANT_ANSIBLE_REMOTE/remote.sh"
