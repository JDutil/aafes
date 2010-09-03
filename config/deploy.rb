set :application, "aafes"
set :user, "root"
set :repository, "."
set :scm, "git"
set :runner, user
set :use_sudo, false
set :branch, "master"
set :deploy_via, :copy
set :git_shallow_clone, 1
set :git_enable_submodules, 1
set :deploy_to, "/home/#{application}"
set :chmod755, %w(log public public/stylesheets public/assets tmp)
#set :group_writable, false
set :server_hostname, 've.qnfzmmzr.vesrv.com'

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

role :web, server_hostname
role :app, server_hostname
role :db, server_hostname, :primary => true

after "deploy:update_code", "deploy:cleanup"
after "deploy:symlink", 'deploy:bundler'

namespace :deploy do

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    #`curl -s http://native-apparel.com  $2 > /dev/null`
  end
  

  desc "run bundler"
  task :bundler, :roles => :app do
    run "cd #{release_path} && bundle install"
  end

end