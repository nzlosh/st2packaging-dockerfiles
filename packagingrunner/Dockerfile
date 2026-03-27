FROM ubuntu:noble

# Additional software (needed for RSpec, serverspec)
RUN DEBIAN_FRONTEND=noninteractive && apt-get -y update
RUN apt-get -y install netcat-traditional build-essential
RUN DEBIAN_FRONTEND=noninteractive && apt-get -y install ruby-full libssl-dev git python3 python3-venv
#RUN rbenv init -
#RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /root/.bashrc
#RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc
#RUN rbenv install 3.1.1
RUN apt-get -y clean

ADD Gemfile /root/Gemfile
RUN gem install bundler
RUN bundle install --gemfile=/root/Gemfile

RUN python3 -m venv /root/.venv
RUN /root/.venv/bin/python3 -m pip install testinfra fabric

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
