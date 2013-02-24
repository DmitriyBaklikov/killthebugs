# Load RVM's capistrano plugin.    
require "rvm/capistrano"
require "bundler/capistrano"

ssh_options[:port] = 2222

set :user, :killthebugs
set :application, "#{user}"

set :rvm_type, :system

set :deploy_to, "/srv/sites/#{application}"
set :rails_env, "production"

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :scm, :git
set :repository,  "git@github.com:vladimirbazhanov/killthebugs.git"
set :branch, "master"

set :keep_releases, 3
set :deploy_via, :remote_cache
set :repository_cache, "cached_copy" 
set :use_sudo, false

task :create_symlinks do
  run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
end

server "178.79.180.63", :app, :web, :db, :primary => true

before "deploy:assets:precompile", :create_symlinks
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do
    run "cd #{current_path} && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end

  task :stop do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  task :restart do
    run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
end
