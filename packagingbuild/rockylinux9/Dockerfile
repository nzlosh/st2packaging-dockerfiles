FROM rockylinux:9

# Download tools
RUN yum -y install \
    ca-certificates \
    wget

RUN yum -y install \
    git \
    openssh

RUN yum install -y yum-utils \
    && dnf install -y dnf-plugin-config-manager \
    && dnf config-manager --enable crb \
    && dnf install -y epel-release \
    && dnf -y install \
    ImageMagick \
    ImageMagick-devel \
    libyaml-devel \
    glibc-langpack-en \
    && dnf remove -y epel-release yum-utils

# Build tools
RUN dnf -y install \
    autoconf \
    automake \
    bzip2 \
    bzip2-devel \
    file \
    gcc \
    gcc-c++ \
    glib2-devel \
    glibc-devel \
    libcurl-devel \
    libevent-devel \
    libffi-devel \
    libjpeg-devel \
    libtool \
    libwebp-devel \
    libxml2-devel \
    libxslt-devel \
    make \
    mysql-devel \
    ncurses-devel \
    openssl-devel \
    patch \
    postgresql-devel \
    readline-devel \
    sqlite-devel \
    xz \
    xz-devel \
    zlib-devel

# St2 package build debs
RUN dnf -y install \
    openldap-devel

# Create busybee credentials and make busybee pkey available for root
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
COPY ../common/busybee* /root/.ssh/
RUN chmod 600 /root/.ssh/busybee && \
    cat root/.ssh/busybee.pub >>/root/.ssh/authorized_keys

RUN yum -y install openssh-server sudo && \
    ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key

# 1. permit root logins and set simple password password and pubkey
# 2. change requiretty to !requiretty in /etc/sudoers
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/'            /etc/ssh/sshd_config && \
    sed -ri 's/^#?PubkeyAuthentication\s+.*/PubkeyAuthentication yes/'  /etc/ssh/sshd_config && \
    sed -ri 's/requiretty/!requiretty/' /etc/sudoers && \
    echo "root:${ROOT_PW}" | chpasswd

RUN dnf -y install nc net-tools

#EL9 enable RSA
RUN update-crypto-policies --set DEFAULT:SHA1

#
# Buildenv is special environment for generating debian packages. It provides:
#   - All needed pre-installed development packages
#   - SSH access for build executor.
#

# Install development tools and python3 for EL9
RUN dnf -y install python3 python3-devel rpmdevtools && \
    pip3 install virtualenv==20.30.0 pip==25.0.1 wheel setuptools

RUN rm -rf /root/.cache

VOLUME ["/home/busybee/build"]
EXPOSE 22

# Run ssh daemon in foreground and wait for bees to connect.
CMD ["/usr/sbin/sshd", "-D"]
