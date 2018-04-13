#!/bin/bash
#@module pp-uxstandard UXモードでの標準前処理
#@desc 1st Holder(default: study-project) 2nd Module & project is temp holder
#@param 1st {String} プロジェクトフォルダ
#@param 2nd {String} モジュール
null=
cmd=$1
holder=$1
module=$2
project=${PWD##*/}
if [[ $holder = "$null" ]]; then
  holder="study-project"
fi
echo "### project: ${project}, holder: ${holder}, module: ${module} ###"
echo "### cmd: ${cmd}"
##
#@module run-fx ドッカー管理コマンド対応
#@param 1st {String} dockerコマンド push/stop/login/export/save
#@require pp-*
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
if [[ $2 != "$null" ]]; then
  it=""
elif [[ $3 != "$null" ]]; then
  it=""
else
  it="-it"
fi
docker run ${it} --rm \
  -v $HOME:/home/docker \
  -v /mnt:/mnt \
  -e AWS_ALIAS=$AWS_ALIAS \
  m0kimura/${project} $1 $2 $3 $4 $5
