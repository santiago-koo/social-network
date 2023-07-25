#!/bin/sh

set -e

echo "ENVIRONMENT: $RAILS_ENV"

# check bundle
echo "Installing gems"
bundle check || bundle install

# Running migrations
echo "Running migrations"
bundle exec rails db:migrate

# removes pid from previous sessions (puma servers)
echo "Removing $APP_PATH/tmp/pids/server.pid"
rm -f $APP_PATH/tmp/pids/server.pid

# run bundle exec to any command
bundle exec ${@}
