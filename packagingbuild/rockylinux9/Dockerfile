FROM rockylinux:9

# Install helper command tool
COPY common/cmdtool /usr/local/bin
COPY common/busybee* /tmp
RUN chmod +x /usr/local/bin/cmdtool

RUN /usr/local/bin/cmdtool configure_base

RUN /usr/local/bin/cmdtool install_download_tools

RUN /usr/local/bin/cmdtool install_system_tools

RUN /usr/local/bin/cmdtool install_build_dependencies

RUN /usr/local/bin/cmdtool install_st2_build_dependencies

RUN /usr/local/bin/cmdtool install_python

VOLUME ["/home/busybee/build"]
EXPOSE 22

# Run ssh daemon in foreground and wait for bees to connect.
CMD ["/usr/sbin/sshd", "-D"]
