set :stage, :staging
set :rails_env, :production

set :version, '1.0.0'
set :branch, 'master'

set :linked_files, %w{.env.production}

set :ssh_options, {
  forward_agent: true
}

server '95.85.14.159', user: 'hlm', roles: %w{web app}
