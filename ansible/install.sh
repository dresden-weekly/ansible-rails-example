#!/bin/bash

ANSIBLE_GIT_REPO=git://github.com/dresden-weekly/ansible.git
ANSIBLE_VERSION=${ANSIBLE_VERSION:=2.0.1-clean}

source $PROJECT_FOLDER/$VAGRANT_ANSIBLE_REMOTE/ansible/git-install.sh
