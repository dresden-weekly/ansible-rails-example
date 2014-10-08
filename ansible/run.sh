#!/bin/bash

VAGRANT_MOUNT=/vagrant
ANSIBLE_VERSION=1.6.10
ANSIBLE_OPTIONS=

ANSIBLE_DIR=/opt/ansible
ANSIBLE_HOSTS=$VAGRANT_MOUNT/ansible/hosts/$1
ANSIBLE_PLAYBOOK=$VAGRANT_MOUNT/ansible/$2.yml
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

echo "Running Ansible"
export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=true
cp $ANSIBLE_HOSTS $TEMP_HOSTS && chmod -x $TEMP_HOSTS
cd $ANSIBLE_DIR
source hacking/env-setup
ansible-playbook $ANSIBLE_OPTIONS $ANSIBLE_PLAYBOOK --inventory-file=$TEMP_HOSTS
rm $TEMP_HOSTS
