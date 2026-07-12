# Docker file is split into multiple stages to produce a smaller runner image.  The entire
# Ruby build from source process is dropped and the rbenv copied to the final runner image.
FROM ubuntu:focal AS rubyinstall

SHELL ["/bin/bash", "-c"]

# Additional software (needed for RSpec, serverspec)
RUN DEBIAN_FRONTEND=noninteractive && apt-get -y update && \
    apt-get -y install git curl wget netcat && apt-get -y clean

# Use rbenv to install ruby 2.2.3p173 (2015-08-18 revision 51636) [x86_64-linux]
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv

RUN ~/.rbenv/bin/rbenv init

# modern rbenv requirements
RUN DEBIAN_FRONTEND=noninteractive && apt-get install -y build-essential \
    autoconf libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc \
    && apt-get -y clean

# older rbenv requirements. (needed on trusty, so old libgdbm6 was adjusted to libgdm6)
RUN DEBIAN_FRONTEND=noninteractive && apt-get install -y patch libreadline6-dev \
    libncurses5-dev libgdbm6 libgdbm-dev libdb-dev && apt-get -y clean

# install rbenv plugin ruby-build to be able to install ruby.
RUN git clone https://github.com/rbenv/ruby-build.git  "$(~/.rbenv/bin/rbenv root)"/plugins/ruby-build

# Compile 2.2.3 and set it as the default ruby interpreter
RUN ~/.rbenv/bin/rbenv install 2.2.3 && ~/.rbenv/bin/rbenv global 2.2.3

# Need Bundler version 1.10.6
RUN export PS1=X; source ~/.bashrc; gem install bundler:1.10.6

ADD packagingrunner/Gemfile /root/Gemfile

RUN export PS1=X; source ~/.bashrc; bundle --gemfile=/root/Gemfile

# Copy Ruby from
FROM ubuntu:focal
COPY --from=rubyinstall /root /root

# Additional software (needed for RSpec, serverspec)
RUN DEBIAN_FRONTEND=noninteractive && apt-get -y update && \
    apt-get -y install git curl wget netcat libyaml-dev && apt-get -y clean

RUN DEBIAN_FRONTEND=noninteractive &&  apt install -y python3 python3-venv

# WIP migrate from rake + rspec + serverspec to fabric + testinfra
RUN /usr/bin/python3 -m venv /root/.venv
RUN /root/.venv/bin/python3 -m pip install testinfra fabric

COPY packagingrunner/docker-entrypoint.sh /entrypoint.sh

COPY common/busybee* /tmp

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh && mv /tmp/busybee* /root/.ssh \
    && cat /root/.ssh/busybee.pub >>/root/.ssh/authorized_keys && chmod 600 /root/.ssh/busybee

ENTRYPOINT [ "/entrypoint.sh" ]
