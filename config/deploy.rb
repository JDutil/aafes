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

#after 'deploy:symlink', 'deploy:symlink_upload_directories', 'deploy:fix_file_permissions'
after "deploy:update_code", "deploy:cleanup"

namespace :deploy do

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    #`curl -s http://native-apparel.com  $2 > /dev/null`
  end
  
  # desc "Fix file permissions" 
  # task :fix_file_permissions, :roles => [ :app, :db, :web ] do 
  #   # Fix permission error occurring after each deployment
  #   # cd /home/native/current/public
  #   # chmod 666 -R ./ 
  #   # find . -type d -exec chmod 777 {} \;
  #   run "cd #{release_path}/public && chmod 666 -R ./"
  #   run "cd #{release_path}/public && find . -type d -exec chmod 777 {} \\;"
  # end

  # desc "Update the crontab file"
  # task :update_crontab, :roles => :db do
  #   run "cd #{release_path} && whenever --update-crontab #{application}"
  # end
	
  # desc "Creates symlinks from shared_path to upload directories for ideas, problems, comics, ..."
  # task :symlink_upload_directories , :roles => :app do
  #   [
  #     'public/assets'
  #   ].each do |upload_path|
  #     run "mkdir -p #{shared_path}/files/#{upload_path}"
  #     run "rm -rf #{current_path}/#{upload_path} && ln -nfs #{shared_path}/files/#{upload_path} #{current_path}/#{upload_path}"
  #   end
  # end
end