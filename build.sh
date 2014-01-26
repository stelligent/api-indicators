#!/bin/bash -e

# For some reason, the Jenkins user doesn't have the path configured correctly...
PATH=$PATH:/usr/local/bin/

# check the syntax of each ruby file
echo Syntax check...
find . -name *.rb | xargs -n1 ruby -c > /dev/null

# Prep and run unit tests
gem install bundler
bundle install
bundle exec rake db:setup
bundle exec rake db:test:prepare
bundle exec rspec spec/ -f d

# Run static analysis
gem install brakeman --version 2.1.1
brakeman -o brakeman-output.tabs
