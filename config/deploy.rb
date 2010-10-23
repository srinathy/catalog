load 'config/private';

set :application, "catalog"

#############################################################
#	Git settings
#############################################################

set :repository,  "git://github.com/brain-geek/#{application}.git"
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
namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
 
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test"
  end
end
 
after 'deploy:update_code', 'bundler:bundle_new_release'

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