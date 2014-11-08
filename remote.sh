#!/bin/sh
if [ ! -z "$1" ] ; then
  if [ -s "ansible/groups/$1.yml" ]; then
    export PROVISION_GROUPS=$1
    PROVISION_VAGRANT=true
    echo Groups: $1
    shift
  elif [ -s "ansible/hosts/$1" ] ; then
    export PROVISION_TARGET=$1
    echo Target: $1
    shift
  fi
fi

if [ ! -z "$1" ] ; then
  if [ -s "ansible/$1.yml" ] ; then
    export PROVISION_ACTION=$1
    echo Action: $1
    shift
  fi
fi

if [ ! -z "$1" ] ; then
  export PROVISION_ARGS=$@
  echo Arguments: $@
fi

export ANSIBLE_DIR=${ANSIBLE_DIR:=`pwd`/.ansible}
if [ "true" = "$PROVISION_VAGRANT" -o "vagrant" = "${PROVISION_TARGET:=vagrant}" ] ; then
  mkdir -p $ANSIBLE_DIR
  PATH=$ANSIBLE_DIR:$PATH
  export PATH
  echo vagrant provision
  exec vagrant provision
else
  echo running ansible
  # export ANSIBLE_HOST_KEY_CHECKING=False
  # export PYTHONUNBUFFERED=1
  # export ANSIBLE_FORCE_COLOR=1
  export BASE_FOLDER=${BASE_FOLDER:=`pwd`/ansible}
  export RUN_ANSIBLE=true
  exec $BASE_FOLDER/run.sh $PROVISION_TARGET ${PROVISION_ACTION:=provision}
fi
