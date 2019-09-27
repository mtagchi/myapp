FROM ruby:2.6.4-buster

RUN gem install -v 6.0.0 rails

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
  apt-get install -y nodejs postgresql-client

RUN curl https://cli-assets.heroku.com/install.sh | sh
