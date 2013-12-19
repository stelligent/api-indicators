echo "cd #{node[:deploy]['canaryboard'][:deploy_to]} && bundle exec rake db:setup"
echo "UYOOOOOO!!!!"
run "cd #{node[:deploy]['canaryboard'][:deploy_to]} && bundle exec rake db:setup"
