#!/bin/bash

# Configure Ruby environment
eval "$(~/.rbenv/bin/rbenv init - --no-rehash bash)"

# Copy Gemfile* to WORKING_DIR
cp /root/Gemfile* ./

# If no operation is given run complete suite (default behaviour)
operation="${1:-complete}"

case "$operation" in
    build)
        bundle exec rake build:all
        ;;
    test)
        bundle exec rake setup:all && bundle exec rspec
        ;;
    complete)
        bundle exec rake && bundle exec rspec
        ;;
    alt-test)
        echo to do: testinfra.
        ;;
    alt-build)
        echo to do: build package fabric
        ;;
    *)
        [ $# -gt 0 ] && exec "$@"
        ;;
esac
