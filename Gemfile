source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails',                    "4.0.4"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',             "~> 4.0.2"
  gem 'coffee-rails',           "~> 4.0.1"
  gem 'uglifier',               "~> 2.5.0"
  gem 'bootstrap-sass',         "~> 3.1.1"

  # Many Linux environments do not have a javascript environment which is
  # required by the asset generators. However, windows and os x have one
  # provided by the system.
  gem 'therubyracer',           "~> 0.12.1" unless RUBY_PLATFORM.match(/darwin|mswin/)
end

gem 'jquery-rails',             "~> 3.1.0"
gem 'turbolinks',               "~> 2.2.1"
gem 'jbuilder',                 "~> 2.0.5"
gem 'mongoid',                  github: "mongoid/mongoid", tag: "v4.0.0.beta1"
gem 'bson_ext'
gem 'sorcery',                  "~> 0.8.5"

group :development, :test do
  gem 'rspec-rails',            "~> 2.14.2"
  gem 'factory_girl_rails',     "~> 4.4.1"
  gem 'spork',                  "~> 0.9.2"
  gem 'faker',                  "~> 1.3.0"
  gem 'capybara',               "~> 2.2.1"
  gem 'glebtv-mongoid-rspec',   "~> 1.12.0"
  gem 'launchy',                "~> 2.4.2"
  gem 'database_cleaner',       "~> 1.2.0"
  gem 'email_spec',             "~> 1.5.0"
end

