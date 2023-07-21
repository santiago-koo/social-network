#!/bin/sh

set -e

echo "ENVIRONMENT: $RAILS_ENV"

# check bundle
bundle check || bundle install

# removes pid from previous sessions (puma servers)

rm -f $APP_PATH/tmp/pids/server.pid

# run bundle exec to any command
bundle exec ${@}
