FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /fu-app-test

WORKDIR /fu-app-test

COPY Gemfile /fu-app-test/Gemfile
COPY Gemfile.lock /fu-app-test/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /fu-app-test

EXPOSE 2700
