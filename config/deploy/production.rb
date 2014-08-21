set :stage, :production
set :rails_env, :production

set :branch, 'master'

set :linked_files, %w{.env.production}

set :ssh_options, {
  forward_agent: true
}

server '54.77.174.155', user: 'hlm', roles: %w{web app}
