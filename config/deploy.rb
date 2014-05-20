# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'hlm'
set :stages, ['staging', 'production']

# Repository
set :scm, :git
set :repo_url, 'git@bitbucket.org:innovantic/hlm.git'

set :deploy_to, '/home/hlm/app'

# Setup RBEnv
set :rbenv_type, :user
set :rbenv_ruby, '2.1.2'

# Linked files/dirs
set :linked_files, %w{.env.production}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 5

# Tasks
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end
