# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'chipotle-cds'
set :repo_url, 'git@github.com:ShubhamGupta/chipotle-cds.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/chipotle'

set :deploy_via, :copy

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

# Default value for default_env is {}
set :default_env, { path: "~/.rvm/rubies/ruby-2.1.1/bin/:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :setup_config do
    on roles(:app) do
      execute "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_chipotle"
    end
  end
  before "deploy", "deploy:setup_config"

  task :app_setup do
    on roles(:app) do
      within release_path do
        # with rails_env: :stage1 do
        execute :bundle, :install
        execute :bundle, :exec, :rake, 'db:migrate'
        execute :bundle, :exec, :rake, "assets:precompile"
        # end
      end
    end
  end

  # %w[start stop restart].each do |command|
  #   desc "#{command} unicorn server"
  #   task command do
  #     on roles(:app) do
  #       execute "/etc/init.d/unicorn_chipotle/unicorn_init.sh #{command}"
  #     end
  #   end
  # end
   
 after :finishing, :app_setup
 # after :app_setup, :unicorn_server

end
