set :application, "trend-finder-frontend"
set :user, "globapd6"
set :use_sudo, false
set :domain, "#{user}@box836.bluehost.com"

set :repository, "#{domain}:/home/#{user}/rails_apps/#{application}"
set :local_repository, "."

default_run_options[:pty] = true

set :scm, :git
set :branch, "master"
set :deploy_to, "/home/#{user}/rails_apps/#{application}"
set :deploy_via, :remote_cache

role :web, domain
role :app, domain
role :db,  domain, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
