set :application, "catalog"
set :gh_username "brain-geek"

load 'config/private'

#############################################################
#	Git settings
#############################################################

set :repository,  "git://github.com/#{gh_username}/#{application}.git"
set :scm, :git
set :deploy_via, :remote_cache

#############################################################
#	Settings
#############################################################

ssh_options[:forward_agent] = true
set :use_sudo, false
set :rails_env, "production" 

#############################################################
#	Servers
#############################################################

set :app_dir, "/home/#{user}/apps/#{application}"
set :deploy_to, "#{app_dir}/deploy"
role :web, domain
role :app, domain
role :db,  domain, :primary => true

#############################################################
#	Tasks
#############################################################

#update bundle
require 'bundler/capistrano'

#set sheduler jobs
require 'lib/whenever/capistrano.rb'

#config files
after "deploy:symlink", :roles => :web do
  run <<-CMD
        ln -nfs #{shared_path}/database.yml #{current_path}/config/database.yml &&
        ln -nfs #{shared_path}/app_config.yml #{current_path}/config/app_config.yml
      CMD
end

#restarting apache
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end