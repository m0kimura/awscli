FROM m0kimura/ubuntu-base

ARG user=${user:-docker}
ARG prj=${prj:-m0kimura}

RUN apt-get update \


##  GET PIP
&&  apt-get install -y python \
&&  wget https://bootstrap.pypa.io/get-pip.py \
&&  chmod +x get-pip.py \
&&  ./get-pip.py \
&&  rm get-pip.py \
##


&&  pip install awscli \
&&  curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest \
&&  chmod +x /usr/local/bin/ecs-cli \
&&  ecs-cli --version \
&&  apt-get install -y jq \

&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*


##  USER
ENV HOME=/home/${user} USER=${user}
WORKDIR $HOME
USER $USER
##

COPY ./starter.sh /usr/bin/starter.sh
COPY ./parts/amazon /usr/bin/amazon
COPY ./parts /usr/src
CMD starter.sh
