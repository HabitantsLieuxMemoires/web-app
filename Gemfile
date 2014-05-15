source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails',                        "4.0.4"

# Environment variables management (before any other gems)
gem 'dotenv-rails',                 "~> 0.10.0", group: [:development, :test]

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',                 "~> 4.0.2"
  gem 'coffee-rails',               "~> 4.0.1"
  gem 'uglifier',                   "~> 2.5.0"

  # Many Linux environments do not have a javascript environment which is
  # required by the asset generators. However, windows and os x have one
  # provided by the system.
  gem 'therubyracer',               "~> 0.12.1" unless RUBY_PLATFORM.match(/darwin|mswin/)
end

# Assets gems
gem 'jquery-rails',                 "~> 3.1.0"
gem 'bootstrap-sass',               "~> 3.1.1"
gem 'jbuilder',                     "~> 2.0.5"
gem 'pluggable_js',                 "~> 2.0.0"
gem 'bootstrap_form',               "~> 2.1.0"
gem 'remotipart',                   "~> 1.2"
gem 'selectize-rails',              "~> 0.9.0"
gem 'font-awesome-rails',           "~> 4.0.3.1"
gem 'momentjs-rails',               "~> 2.5.1"
gem 'underscore-rails',             "~> 1.6.0"
gem 'bootstrap-wysihtml5-rails',    "~> 0.3.1.23"
gem 'leaflet-rails',                "~> 0.7.2"
gem 'leaflet-markercluster-rails',  "~> 0.7.0"
gem 'modernizr-rails',              "~> 2.7.1"

# Mongoid gems
gem 'mongoid',                      github: "mongoid/mongoid", tag: "v4.0.0.beta1"
gem 'bson_ext'
gem 'mongoid_taggable',             "~> 1.1.1"
gem 'mini_magick',                  github: "minimagick/minimagick", tag: "v3.7.0"
gem 'carrierwave-mongoid',          "~> 0.7.1"
gem 'mongoid_magic_counter_cache',  "~> 1.1.0"
gem 'mongoid-audit',                "~> 0.3.2"
gem 'mongoid_slug',                 "~> 3.2.1"
gem 'mongoid_alize',                "~> 0.4.3"

# Misc gems
gem 'sorcery',                      "~> 0.8.5"  # Authentication
gem 'seedbank',                     "~> 0.3.0"  # Seeding
gem 'kaminari',                     "~> 0.15.1" # Pagination
gem 'bootstrap-kaminari-views',     "~> 0.0.3"  # Bootstrap Pagination
gem 'draper',                       "~> 1.3.0"  # ViewModels
gem 'searchkick',                   "~> 0.7.2"  # Search (ElasticSearch)
gem 'cells',                        "~> 3.10.1" # Cell view components
gem 'nokogiri',                     "~> 1.6.1"  # HTML Parsing
gem 'video_info',                   "~> 2.3.1"  # Video embedding
gem 'diffy',                        "~> 3.0.4"  # Diffing
gem 'rails-i18n',                   "~> 4.0.2"  # I18n

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'rspec-rails',                "~> 2.14.2"
  gem 'factory_girl_rails',         "~> 4.4.1"
  gem 'spork-rails',                "~> 4.0.0"
  gem 'faker',                      "~> 1.3.0"
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner',           "~> 1.2.0"
  gem 'email_spec',                 "~> 1.5.0"
  gem 'glebtv-mongoid-rspec',       "~> 1.12.0"
  gem 'launchy',                    "~> 2.4.2"
end
