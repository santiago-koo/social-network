FROM ruby:3.1.4-alpine

ENV APP_DIR="/usr/local/app/" \
    BUILD_PACKAGES="curl-dev build-base bash" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev postgresql-dev postgresql-client libpq" \
    RUBY_PACKAGES="ruby-json yaml nodejs"

WORKDIR $APP_DIR

RUN apk update && \
    apk upgrade && \
    apk add --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN gem install bundler --version 2.3.26

COPY . $APP_DIR

COPY ./dev-entrypoint.sh /usr/local/bin/dev-entrypoint.sh
RUN chmod +x /usr/local/bin/dev-entrypoint.sh

RUN bundle install
RUN bundle exec rake assets:precompile

EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
