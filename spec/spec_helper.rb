require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'

  # require rspec support files
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

    # Drop databases before each spec
    config.before do
      Mongoid.purge!
    end


    # Include Factory Girl syntax to simplify calls to factories
    config.include FactoryGirl::Syntax::Methods

    # Include Sorcery helpers
    config.include Sorcery::TestHelpers::Rails
  end

end

Spork.each_run do
  FactoryGirl.reload
end