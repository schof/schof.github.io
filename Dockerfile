FROM alpine:3.5
MAINTAINER rlister@gmail.com

RUN apk update && \
    apk upgrade && \
    apk add \
    bash build-base linux-headers ca-certificates \
    ruby ruby-dev ruby-io-console \
    libffi-dev libxml2-dev libxslt-dev \
    nginx \
    && \
    rm -rf /var/cache/apk/*

## install bundle
RUN gem install bundler --no-rdoc --no-ri

## cache the bundle
WORKDIR /app
ADD Gemfile* /app/
ENV CUSTOM_RUBY_VERSION 2.3.3
RUN bundle install
#--without development test

ADD . /app/
RUN bundle exec jekyll build --future
COPY config/nginx.conf /etc/nginx/nginx.conf

## TODO replace with nginx
# CMD ["bundle", "exec", "jekyll serve -H 0.0.0.0"]
CMD ["nginx"]