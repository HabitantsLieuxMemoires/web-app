set :stage, :staging
set :rails_env, :production

set :version, '1.0.0'
set :branch, "release/#{fetch(:version)}"

set :linked_files, %w{.env.staging}

set :ssh_options, {
  forward_agent: true,
  port: 22501
}

server '95.85.14.159', user: 'hlm', roles: %w{web app}
