require "application_system_test_case"

class SearchResultsTest < ApplicationSystemTestCase
  test "searching episodes" do
    episode = create(:episode, title: "Episode Title")

    visit podcast_episodes_path(episode.podcast)
    click_on "Search"
    within :main, "Search" do
      fill_in "Query", with: "title", focused: true
      click_on "Search"
    end

    within :main, "Search Results" do
      assert_selector :article, episode.title, count: 1
    end
  end
end
