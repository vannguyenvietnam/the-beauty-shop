set :application, "The Beauty Shop"
set :repository,  "git@bitbucket.org:vannguyenvietnam/the_beauty_shop.git"

set :scm, :git
set :branch, "master"
set :deploy_to, "/var/www/example.com"
set :user, "van"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :keep_releases, 5

server "167.160.168.77", :app, :web, :db, :primary => true
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

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