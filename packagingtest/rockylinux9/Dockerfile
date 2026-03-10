FROM rockylinux:9

ENV container=docker

# Install helper command tool
COPY common/cmdtool /usr/local/bin
COPY common/busybee* /tmp
RUN chmod +x /usr/local/bin/cmdtool

RUN /usr/local/bin/cmdtool install_download_tools

RUN /usr/local/bin/cmdtool configure_base

RUN /usr/local/bin/cmdtool install_build_dependencies

RUN /usr/local/bin/cmdtool install_st2_build_dependencies

RUN /usr/local/bin/cmdtool install_system_tools

RUN /usr/local/bin/cmdtool install_locale

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN /usr/local/bin/cmdtool configure_testing_system

EXPOSE 22

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "/usr/sbin/init" ]
