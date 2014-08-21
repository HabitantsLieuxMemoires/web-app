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

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end

task :setup do
  invoke 'deploy:copy_env'
end
