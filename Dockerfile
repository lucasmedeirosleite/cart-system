FROM ruby:2.4.2

# Add the official node distributions repository
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install -y build-essential libpq-dev nodejs \
                       postgresql-client imagemagick \
                       libmagic-dev \
                       procps libicu-dev --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENV APP_HOME /cart-system
WORKDIR $APP_HOME

ENV GEM_HOME /gems
ENV BUNDLE_PATH $GEM_HOME
ENV PATH $GEM_HOME/bin:$PATH
ENV HISTFILE $APP_HOME/tmp/docker_histfile

# Config for the terminal
ADD .bashrc /root/.bashrc

RUN bundle config --global jobs 8
RUN bundle config --global retry 3

ENV LANG C.UTF-8

ADD . $APP_HOME

CMD ./script/start
