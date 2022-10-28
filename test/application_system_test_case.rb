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

  def assert_audio(...)
    assert_selector(:audio, ...)
  end

  def assert_no_audio(...)
    assert_no_selector(:audio, ...)
  end
end

Capybara.add_selector :audio do
  css { "audio" }

  locator_filter do |node, locator|
    case locator
    when Regexp then locator.match?(node[:src])
    else true
    end
  end

  node_filter(:paused, valid_values: [TrueClass, FalseClass]) do |node, value|
    paused = node[:paused]

    if value
      /true/i.match?(paused)
    else
      /false/i.match?(paused)
    end
  end

  node_filter(:played, valid_values: [TrueClass, FalseClass]) do |node, value|
    current_time = node[:currentTime].to_f

    if value
      current_time.positive?
    else
      current_time.zero?
    end
  end

  node_filter(:playing, valid_values: [TrueClass, FalseClass]) do |node, playing|
    node.matches_selector?(:audio, played: playing, paused: !playing)
  end
end
