require 'bundler/capistrano'

set :application, "aafes"
set :user, "deploy"
set :repository, "git@github.com:jdutil/aafes.git"
set :scm, "git"
set :runner, user
set :use_sudo, false
set :branch, "master"
set :deploy_via, :copy
set :git_shallow_clone, 1
set :git_enable_submodules, 1
set :deploy_to, "/home/#{user}/#{application}"
set :chmod755, %w(log public public/stylesheets public/assets tmp)
set :server_hostname, 'burlingtonwebapps.com'

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

role :web, server_hostname
role :app, server_hostname
role :db, server_hostname, :primary => true

after "deploy:update_code", "deploy:cleanup"

namespace :deploy do

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    `curl -s http://aafes.burlingtonwebapps.com  $2 > /dev/null`
  end

end