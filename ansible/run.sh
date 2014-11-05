#!/bin/bash

BASE_FOLDER=${BASE_FOLDER:=`pwd`}
ANSIBLE_VERSION=1.7.1
ANSIBLE_OPTIONS=

ANSIBLE_DIR=${ANSIBLE_DIR:=$HOME/ansible}
export ANSIBLE_ROLES_PATH=${ANSIBLE_ROLES_PATH:=$ANSIBLE_DIR/roles}
ANSIBLE_HOSTS=$BASE_FOLDER/hosts/$1
ANSIBLE_PLAYBOOK=$BASE_FOLDER/$2.yml
TEMP_HOSTS="/tmp/local_hosts"

if [ ! -f $ANSIBLE_PLAYBOOK ]; then
  echo "Cannot find Ansible playbook $ANSIBLE_PLAYBOOK"
  exit 1
fi

if [ ! -f $ANSIBLE_HOSTS ]; then
  echo "Cannot find Ansible hosts $ANSIBLE_HOSTS"
  exit 2
fi

if [ -f ${ANSIBLE_DIR}/VERSION ]; then
  if [ $(<${ANSIBLE_DIR}/VERSION) != $ANSIBLE_VERSION ]; then
    echo "Removing old Ansible version $(<${ANSIBLE_DIR}/VERSION)"
    rm -rf ${ANSIBLE_DIR}
  fi
fi

if [ ! -d $ANSIBLE_DIR ]; then
  echo "Updating apt cache"
  apt-get update -qq
  echo "Installing Ansible dependencies and Git"
  apt-get install -y git python-yaml python-paramiko python-jinja2
  echo "Cloning Ansible"
  git clone --branch release$ANSIBLE_VERSION --depth 1 git://github.com/ansible/ansible.git $ANSIBLE_DIR
fi
mkdir -p $ANSIBLE_ROLES_PATH

echo "Running Ansible"
cp $ANSIBLE_HOSTS $TEMP_HOSTS && chmod -x $TEMP_HOSTS
cd $ANSIBLE_DIR
source hacking/env-setup
ansible-galaxy install dresden-weekly.Rails
ansible-playbook $ANSIBLE_OPTIONS $ANSIBLE_PLAYBOOK --inventory-file=$TEMP_HOSTS
rm $TEMP_HOSTS
