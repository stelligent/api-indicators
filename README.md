CanaryBoard
==============

## Description

This app lets you inform people about the status of services you provide and projects you're responsible for.
Clean installation has a superuser account with ```admin:admin``` credentials; be sure to change it after first login.

While Rails can be installed on many operating systems, we've include detailed instructions for installing on Ubuntu 12.04 LTS.

## Configuration of Linux Instance

You'll need to first download and install Ubuntu 12.04 LTS. To do this, go to [Ubuntu](http://releases.ubuntu.com/precise/).


## Installing Rails on Ubuntu 12.04 LTS

After you've installed Ubunu, follow the instructions below (which were adpated from [digitalocean](https://www.digitalocean.com/community/articles/how-to-install-ruby-on-rails-on-ubuntu-12-04-lts-precise-pangolin-with-rvm))

1. ```sudo apt-get update```
1. ```sudo apt-get install curl```
1. ```\curl -L https://get.rvm.io | bash -s stable```
1. ```source ~/.rvm/scripts/rvm```
1. ```rvm requirements```
1. ```rvm install 1.9.3```
1. ```rvm use 1.9.3 --default```
1. ```rvm rubygems current```
1. ```gem install rails```
1. ```sudo apt-get install nodejs```
1. ```sudo apt-get install git```
1. ```sudo apt-get install libxslt-dev libxml2-dev```

## Installing CanaryBoard

Now that you've intalled Ruby and other packages, you will install CanaryBoard on this instance.

1. ```git clone https://github.com/stelligent/canaryboard.git```
1. ```cd canaryboard```
1. ```bundle install```
1. ```bundle exec rake db:setup```
1. ```bundle exec rake db:test:prepare```
1. ```bundle exec rspec spec/```
1. ```rails s```

## Running CanaryBoard

1. Launch and web browser and type http://[hostname]:3000
1. Login to the application using the default credentials (```admin:admin```).

## Using CanaryBoard

After your CanaryBoard Rails app is up and running, you can use the examples here: 

* **set-indicators.rb** - You can customize [set-indicators.rb](https://gist.github.com/PaulDuvall/552cbe661e0e943a0de1)
* **update-indicators.rb** - You can customize and [update-indicators.rb](https://gist.github.com/PaulDuvall/f6c59b78fc8af286f5c8). 
* You can also view [api-usage-example](https://github.com/stelligent/canaryboard/blob/master/script/api-usage-example) to update the status indicators for projects and services

## More Information

For more information, you can read the [Agile DevOps: Build a DevOps dashboard](http://www.ibm.com/developerworks/agile/library/a-devops10/) from IBM developerWorks on using CanaryBoard.
