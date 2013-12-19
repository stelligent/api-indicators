run "pwd && cd #{node[:deploy]['canaryboard'][:deploy_to]} && bundle exec rake db:setup"
