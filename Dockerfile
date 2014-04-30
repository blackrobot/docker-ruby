# damon/ruby

FROM damon/base

# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qqy \
    autoconf \
    bison \
    build-essential \
    libssl-dev \
    libyaml-dev \
    libreadline6 \
    libreadline6-dev \
    zlib1g \
    zlib1g-dev

# Install rbenv
RUN git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv

# Install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/ruby-build && \
    /usr/local/ruby-build/install.sh

# Setup rbenv
ENV RBENV_ROOT /usr/local/rbenv
ENV PATH $RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH
ENV CONFIGURE_OPTS --disable-install-doc

RUN echo "export RBENV_ROOT=${RBENV_ROOT}" >> /etc/profile.d/rbenv.sh && \
    echo "export PATH=${RBENV_ROOT}/shims:${RBENV_ROOT}/bin:\$PATH" >> /etc/profile.d/rbenv.sh && \
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN eval "$(rbenv init -)"

# Install ruby 2.1.0
RUN /usr/local/rbenv/bin/rbenv install 2.1.0
RUN /usr/local/rbenv/bin/rbenv global 2.1.0

# Install bundler
RUN echo "gem: --no-document" > /.gemrc
RUN gem install bundler
