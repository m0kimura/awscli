FROM m0kimura/ubuntu-base

#@module ux-tool ツールのインストール共通基本前処理
#@desc ここで準備したものは、ux-closeで整理されます。
#@desc user変数を省略時に「docker」設定
ARG user=${user:-docker}
RUN echo "### ux-tool ###" \
&&  apt-get update \
&&  apt-get install -y unzip curl
##
#@module ux-getpip get-pipのインストール
RUN echo "### ux-getpip ###" \
&&  wget https://bootstrap.pypa.io/get-pip.py \
&&  chmod +x get-pip.py \
&&  ./get-pip.py \
&&  rm get-pip.py
##
#@module ux-aws aws toolのインストール
#@desc 対象モジュール:awscli. ecs-cli, s3fs, jq(JSON handler)
#@requre ux-tool, ux-pip
RUN echo "### aws ###" \
&&  chown root:root /usr/local/lib/node_modules -R \
&&  npm install -g ask-cli \
&&  pip install awscli \
&&  curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest \
&&  chmod +x /usr/local/bin/ecs-cli \
&&  ecs-cli --version \
&&  apt-get update \
&&  apt-get install -y automake autotools-dev fuse g++ \
      libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config \
&&  git clone https://github.com/s3fs-fuse/s3fs-fuse.git \
&&  cd s3fs-fuse \
&&  ./autogen.sh \
&&  ./configure \
&&  make \
&&  make install \
&&  apt-get install -y jq
##
#@module ux-close インストール残骸を削除します。
#@desc ux-toolとペアで使用することを想定してます。
RUN echo "### ux-close ###" \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*
##
COPY ./parts/aex /usr/bin/aex
COPY ./parts/Helps /usr/bin/Helps
COPY ./parts /usr/src
#@module ux-user 標準ユーザー環境による実行 です。
ENV HOME=/home/${user} USER=${user}
WORKDIR $HOME
USER $USER
RUN echo "### ux-user ###" \
&&  echo "export LANG=ja_JP.UTF-8" >> .bashrc
COPY ./starter.sh /usr/bin/starter.sh
ENTRYPOINT ["starter.sh"]
CMD ["none"]
##
