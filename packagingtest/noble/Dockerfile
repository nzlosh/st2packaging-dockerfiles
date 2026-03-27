FROM ubuntu:noble

ENV container=docker
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive

# Install helper command tool
COPY common/cmdtool /usr/local/bin
COPY common/busybee* /tmp
COPY common/setup.sh /sbin/
RUN chmod +x /usr/local/bin/cmdtool

RUN /usr/local/bin/cmdtool configure_base

RUN /usr/local/bin/cmdtool install_system_tools

RUN /usr/local/bin/cmdtool install_locale
ENV LANG=en_US.UTF-8

RUN /usr/local/bin/cmdtool install_download_tools

RUN /usr/local/bin/cmdtool configure_testing_system

RUN systemctl preset ssh;

EXPOSE 22

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "/sbin/init" ]
