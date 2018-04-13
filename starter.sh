#!/bin/bash
#
null=
holder=$1
module=$2
op=$3
data=$4
##
  if [[ ! -e $HOME/awslib ]]; then
    mkdir $HOME/awslib
    cp /usr/src/*.json $HOME/awslib/
    cp /usr/src/*.conf $HOME/awslib/
  fi
##
  if [[ $holder = "none" ]]; then
    holder="study-project"
    echo "aexコマンドが使えます。　Helps aexで使い方表示"
  elif [[ $1 = 'ask-init' ]]; then
    aex ask
  elif [[ $1 = 'skill-init' ]]; then
    if  [[ $2 = "$null" ]]; then
      echo "2nd opeland is null"
      exit
    fi
    name=$(echo $2 | cut -d '/' -f 6)
    aex skill ${name}
  fi
  cd $holder
  if [[ $module = "$null" ]]; then
    aws --version
    ecs-cli --version
    ask --version
    aex help
    /bin/bash
  else
    if [[ ! -e aws ]]; then
      mkdir aws
    fi
    cd aws
    if [[ $op = "$null" ]]; then
      /bin/bash
    elif [[ $op = '.ask' ]]; then
      aex skilll-deploy
    elif [[ $op = 'skill.json' ]]; then
      aex skill-update ${module}
    elif [[ $op = 'models' ]]; then
      aex skill-model ${module} ${data}
    else
      echo "### ERROR 3rd opeland=$op ###"
    fi
  fi
