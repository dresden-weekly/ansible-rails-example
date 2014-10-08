#!/bin/sh
if [ ! -z "$1" ] ; then
  if [ -s "ansible/hosts/$1" ] ; then
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

echo vagrant provision
exec vagrant provision
