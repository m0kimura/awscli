#!/bin/bash
cmd=$1
project=${PWD##*/}


##  FX UTILITY
  if [[ ${cmd} = "push" ]]; then
    dex push
    exit
  elif [[ ${cmd} = "stop" ]]; then
    docker stop fx-${project}
    exit
  elif [[ ${cmd} = "login" ]]; then
    docker exec -it fx-${project} /bin/bash
    exit
  elif [[ ${cmd} = "export" ]]; then
    echo Export Container fx-${project} to local/fx-${project}.tar
    docker export fx-${project} -o ../local/fx-${project}.tar
    exit
  elif [[ ${cmd} = "save" ]]; then
    echo Save Image ${project} to local/${project}.tar
    docker save ${project} -o ../local/${project}.tar
    exit
  fi
##
##
  docker run -it --rm \
    -v $HOME:/home/docker \
    m0kimura/${project}
##
