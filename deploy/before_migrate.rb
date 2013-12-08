# rails_env = new_resource.environment["RAILS_ENV"]
# Chef::Log.info("Setting up database for RAILS_ENV=#{rails_env}...")
# execute "rake db:setup" do
#   cwd release_path
#   command "bundle exec rake db:setup"
#   environment "RAILS_ENV" => rails_env
# end
