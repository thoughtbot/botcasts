ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "action_text/system_test_helper"

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class ActionDispatch::IntegrationTest
  include CapybaraAccessibleSelectors::Session
end

class FactoryBot::SyntaxRunner
  def file_fixture(basename)
    file_fixture_path.join(basename)
  end

  def file_fixture_path
    Rails.root.join("test/fixtures/files")
  end
end

Capybara.configure do |config|
  config.enable_aria_label = true
end
