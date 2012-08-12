#require "bundler/capistrano"

run_locally("git push bluehost")

set :application, "trend-finder-frontend"
set :domain, "global-trend-finder.com"
set :user, "globapd6"
set :use_sudo, false

set :repository, "file:///home/#{user}/repository/#{application}.git"
set :local_repository, "ssh://#{user}@#{domain}/home/#{user}/repository/#{application}.git"

default_run_options[:pty] = true

set :scm, :git
set :branch, "master"
set :deploy_to, "/home/#{user}/rails_apps/#{application}"
set :deploy_via, :export

role :web, domain
role :app, domain
role :db,  domain, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :restart do
    run "cd #{current_path} && bundle install"
  end
end

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
