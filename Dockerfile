FROM ruby:2.1.2

RUN apt-get update -qq &&  \
    apt-get install -y build-essential \
      xvfb libpq-dev libqtwebkit-dev imagemagick git libcurl4-openssl-dev libreadline-dev libssl-dev \
      libxml2-dev libxslt1-dev zlib1g-dev

RUN mkdir /app

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

ADD . /app
