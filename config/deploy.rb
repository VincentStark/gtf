require 'bundler/capistrano'

set :application, "trend-finder-frontend"
set :user, "globapd6"
set :domain, "global-trend-finder.com"
set :use_sudo, false

set :scm, :git
set :branch, "master"

set :repository, "file:///home/#{user}/repository/#{application}.git"
#set :local_repository, "ssh://#{user}@#{domain}/home/#{user}/repository/#{application}.git"
set :local_repository, "."

set :deploy_to, "/home/#{user}/rails_apps/#{application}"
set :deploy_via, :remote_cache

server domain, :app, :web, :db, :primary => true

#namespace :deploy do
  #@run_locally("git push bluehost")
  #task :restart do
    #run "touch #{File.join(current_path,'tmp','restart.txt')}"
  #end
#end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

after "deploy:restart", "deploy:cleanup"
