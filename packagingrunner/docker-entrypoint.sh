#!/bin/bash

# Copy Gemfile* to WORKING_DIR
cp /root/Gemfile* ./

# If no operation is given run complete suite (default behaviour)
operation="${1:-complete}"

case "$operation" in
    build)
        rake build:all
    ;;
    test)
        rake setup:all && rspec
    ;;
    complete)
        rake && rspec
    ;;
    *)
        [ $# -gt 0 ] && exec "$@"
    ;;
esac
