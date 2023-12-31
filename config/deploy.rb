# config valid for current version and patch releases of Capistrano
lock '~> 3.17.1'

set :application, 'arenaease'
set :repo_url, 'git@github.com:femanix/arenaease.git'

set :default_branch, 'main'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, ENV['BRANCH'] || fetch(:default_branch)

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/arenaease'

# Default value for :format is :airbrussh.
set :format, :airbrussh
set :log_level, :debug

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'tmp/webpacker', 'public/system', 'vendor',
       'storage'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before the first deploy.
# set :ssh_options, verify_host_key: :secure

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '3.1.2'

set :rbenv_prefix,
    "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

after 'deploy:finished', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end

namespace :test do
  desc 'Deploy to the test environment'
  task :deploy do
    on roles(:app) do
      set :deploy_to, '/var/www/test.arenaease'
      set :rails_env, 'test'
      set :current_settings, {
        unicorn_worker_processes: 2
        # outras configurações específicas para o ambiente de teste
      }
      invoke 'deploy'
    end
  end
end
