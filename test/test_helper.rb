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

    def with_pagy_defaults(**overrides)
      defaults = Pagy::DEFAULT.dup

      Pagy::DEFAULT.merge!(overrides)

      yield
    ensure
      Pagy::DEFAULT.merge!(defaults)
    end
  end
end

class ActionDispatch::IntegrationTest
  include CapybaraAccessibleSelectors::Session

  def assert_form(buttons: [], **attributes, &block)
    buttons = buttons.map { Array(_1) }

    assert_selector(:element, "form", **attributes) do |form|
      if buttons.any?
        buttons.all? do |button|
          filters = button.extract_options!

          form.has_button?(*button, **filters)
        end
      else
        form.yield_self(&block)
      end
    end
  end
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
