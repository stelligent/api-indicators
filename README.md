CanaryBoard
==============

## Description

This app lets you inform people about the status of services you provide and projects you're responsible for. 
Clean installation has a superuser account with ```admin:admin``` credentials; be sure to change it after first login.

While Rails can be installed on many operating systems, we've include detailed instructions for installing on Ubuntu 12.04 LTS.

## Installation of Rails on Ubuntu 12.04 LTS
1. ```sudo apt-get install git```


## Installation of CanaryBoard

1. ```git clone https://github.com/stelligent/canaryboard.git```
1. ```cd canaryboard```
1. ```bundle install```
1. ```bundle exec rake db:setup```
1. ```bundle exec rake db:test:prepare```
1. ```bundle exec rspec spec/```
1. ```bundle exec rake db:test:prepare```
1. ```bundle exec rspec spec/```
1. ```rails s```
