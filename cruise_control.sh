#!/usr/bin/env bash

source $HOME/.rvm/scripts/rvm

# Kill the whole script on error
set -e

# Ensure groups exist
rvm use 1.8.7@moz_nav --create
rvm use 1.9.2@moz_nav --create

# Install the gems
rvm 1.8.7@moz_nav,1.9.2@moz_nav exec bundle install --without os_x

# Run the specs
rvm 1.8.7@moz_nav,1.9.2@moz_nav exec bundle exec rake cruise

