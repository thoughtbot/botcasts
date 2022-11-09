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

  test "scrolling loads the next page of episodes" do
    with_pagy_defaults items: 10 do
      query = "A match"
      podcast = create(:podcast)
      top_episode, bottom_episode, * = 11.times.map { create(:episode, podcast:, title: "##{_1}: #{query}") }

      visit podcast_search_results_path(podcast, query:)

      within :main do
        assert_no_selector :article, top_episode.title
        assert_link "Load older episodes"

        scroll_to find :article, bottom_episode.title

        assert_no_link "Load older episodes"
        assert_selector :article, top_episode.title
      end
    end
  end

  test "load the previous page of episodes from the link" do
    with_pagy_defaults items: 10 do
      query = "A match"
      podcast = create(:podcast)
      top_episode, bottom_episode, * = 11.times.map { create(:episode, podcast:, title: "##{_1}: #{query}") }

      visit podcast_search_results_path(podcast, query:, page: 2)

      within :main do
        assert_link "Load newer episodes"
        assert_selector :article, top_episode.title
        assert_no_link "Load older episodes"

        click_on "Load newer episodes"

        assert_selector :article, bottom_episode.title
        assert_no_selector :article, top_episode.title
      end
    end
  end
end
