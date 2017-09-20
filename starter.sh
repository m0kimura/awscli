#!/bin/bash
#
null=
##
  if [[ ! -e $HOME/awslib ]]; then
    mkdir $HOME/awslib
    cp /usr/src/*.json $HOME/awslib/*.json
    cp /usr/src/*.conf $HOME/awslib/*.conf
  fi
  if [[ $DIR != "$null" ]]; then
    cd $DIR
  fi
  echo PWD=$(pwd) MODULE=$MODULE DIR=$DIR
  if [[ $MODULE = "$null" ]]; then
    aws --version
    ecs-cli --version
    /bin/bash
  else
    ./$MODULE
  fi
