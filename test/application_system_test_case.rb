require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  def tab_until_focused(*arguments, times: 1000.times, focused: true, wait: 0, **options, &block)
    times.each do
      if page.has_selector?(*arguments, **options, focused:, wait:, &block)
        break
      else
        send_keys(:tab)
      end
    end
  end
end
