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
  require 'coffee_script'
  require 'sass'
  require 'mongoid-audit'

  RSpec.configure do |config|
    config.mock_with :rspec

    # Setting Capybara JS driver
    Capybara.javascript_driver = :webkit

    # Drop databases and clear files before each spec
    config.before(:suite) { DatabaseCleaner[:mongoid].strategy = :truncation }
    config.before(:each) do
      DatabaseCleaner[:mongoid].start
      Article.reindex
    end
    config.after(:each) do
      DatabaseCleaner[:mongoid].clean
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    end

    # Include Factory Girl syntax to simplify calls to factories
    config.include FactoryGirl::Syntax::Methods

    # Include Sorcery helpers
    config.include Sorcery::TestHelpers::Rails

    # Include email helpers
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)

    # Include file helpers
    config.include(ActionDispatch::TestProcess)

    Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  end

end

Spork.each_run do
  require 'factory_girl_rails'
  FactoryGirl.reload
end
