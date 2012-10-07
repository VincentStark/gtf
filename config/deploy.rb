# Automatic "bundle install" after deploy
require 'bundler/capistrano'

# RVM integration
require 'rvm/capistrano'

# Assets precompile
load 'deploy/assets'

# Application name
set :application, "gtf"

# Username
set :user, "ec2-user"

# App Domain
set :domain, "global-trend-finder.com"

# Minor tweaks
set :use_sudo, false
set :rvm_install_with_sudo, true
set :rvm_type, :system

# git is our SCM
set :scm, :git

# Use github repository
set :repository, "git://github.com/vasily-ponomarev/gtf.git"

# gtf is our default git branch
set :branch, "gtf"

# Deploy local copy
set :deploy_via, :remote_cache
set :deploy_to, "/var/rails/#{application}"

# We have all components of the app on the same server
server domain, :app, :web, :db, :primary => true

# Install rvm before deploy
before 'deploy:setup', 'rvm:install_rvm'

# Unicorn setup
set :rails_env, :production
set :unicorn_binary, "unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn.conf.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
set :su_rails, "sudo -u rails"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    # Normalize permissions
    run "mkdir #{current_path}/tmp"
    run "#{sudo} chgrp -R rails #{current_path}/tmp"
    run "#{sudo} chmod 775 #{current_path}/tmp"
    run "#{sudo} chgrp -R rails #{current_path}/log"
    run "#{sudo} chmod 775 #{current_path}/log"
    # Launch unicorn
    run "cd #{current_path} && #{su_rails} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "#{su_rails} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{su_rails} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{su_rails} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end

# Clean-up old releases
after "deploy:restart", "deploy:cleanup"
