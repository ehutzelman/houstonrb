default_run_options[:pty] = true

set :application, "houstonrb"
set :repository,  "git@github.com:ehutzelman/houstonrb.git"

set :deploy_via, :remote_cache
set :deploy_to, "/Users/eric/Projects/#{application}"

set :scm, :git
set :scm_command, "/usr/local/git/bin/git"

set :domain, "raptor"
role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end  
  
  desc "copy the private settings in config/application.yml to the servers" 
  task :copy_application_yml do
    put(File.read("config/application.yml"), "#{release_path}/config/application.yml")
  end  
end
  
after "deploy:update_code", "deploy:copy_application_yml"
  