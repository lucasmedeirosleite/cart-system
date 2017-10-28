FROM ruby:2.4.2

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install -y build-essential nodejs libpq-dev procps libicu-dev --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV HISTFILE $APP_HOME/tmp/docker_histfile

ENV APP_HOME /cart-system
WORKDIR $APP_HOME

ADD . $APP_HOME

RUN bundle install
