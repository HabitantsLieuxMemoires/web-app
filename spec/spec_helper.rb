require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  # Mongoid models reload
  require 'rails/mongoid'
  Spork.trap_class_method(Rails::Mongoid, :load_models)

  # Routes and app/ classes reload
  require 'rails/application'
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  Spork.trap_method(Rails::Application, :eager_load!)

  # Load railties
  require File.expand_path('../../config/environment', __FILE__)

  # General require
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'database_cleaner'
  require 'email_spec'

  RSpec.configure do |config|
    config.mock_with :rspec

    # Drop databases before each spec
    config.before(:suite) { DatabaseCleaner[:mongoid].strategy = :truncation }
    config.before(:each)  { DatabaseCleaner[:mongoid].start }
    config.after(:each)   { DatabaseCleaner[:mongoid].clean }

    # Include Factory Girl syntax to simplify calls to factories
    config.include FactoryGirl::Syntax::Methods

    # Include Sorcery helpers
    config.include Sorcery::TestHelpers::Rails

    # Include email helpers
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)

    Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  end

end

Spork.each_run do
  require 'factory_girl_rails'
  FactoryGirl.reload
end
