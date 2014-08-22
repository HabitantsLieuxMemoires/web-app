# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'hlm'
set :stages, ['staging', 'production']

# Repository
set :scm, :git
set :repo_url, 'git@github.com:HabitantsLieuxMemoires/web-app.git'

set :deploy_to, '/home/hlm/app'

# Setup RBEnv
set :rbenv_type, :user
set :rbenv_ruby, '2.1.2'

# Linked files/dirs
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 5

# Tasks
namespace :deploy do

  desc 'Copy dotenv configuration'
  task :copy_env do
    on roles(:app) do
      upload! ".env.#{fetch(:stage)}", "#{shared_path}"
    end
  end

end

task :setup do
  invoke 'deploy:copy_env'
end
