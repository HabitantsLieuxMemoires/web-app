set :stage, :production
set :rails_env, :production

set :branch, 'master'

set :linked_files, %w{.env.production}

set :ssh_options, {
  forward_agent: true
}

set :nginx_server_name, 'habitantslieuxmemoires.fr'
set :unicorn_workers, 4

server '54.77.157.145', user: 'hlm', roles: %w{web app}
