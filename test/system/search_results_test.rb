require "application_system_test_case"

class SearchResultsTest < ApplicationSystemTestCase
  test "searching episodes" do
    podcast = create(:podcast)
    create(:episode, podcast:, title: "Episode One")
    create(:episode, podcast:, title: "Episode Two")

    visit podcast_episodes_path(podcast)
    send_keys [:meta, "k"]
    within :main, "Search" do
      tab_until_focused(:field, "Query")
      fill_in "Query", with: "episode"
      send_keys :enter
    end

    within :main, %(Search Results for "episode") do
      assert_selector :article, "Episode One", count: 1
      assert_selector :article, "Episode Two", count: 1
    end

    fill_in "Query", with: "episode two"
    send_keys :enter

    within :main, %(Search Results for "episode two") do
      assert_selector :article, "Episode Two", count: 1
      assert_no_selector :article, "Episode One"
    end
  end
end
