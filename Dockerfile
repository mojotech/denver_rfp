FROM ruby:2.5.3

RUN mkdir /client
WORKDIR /client

COPY client/Gemfile Gemfile
COPY client/Gemfile.lock Gemfile.lock

RUN bundle install

COPY client /client
