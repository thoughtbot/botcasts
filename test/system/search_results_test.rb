require "application_system_test_case"

class SearchResultsTest < ApplicationSystemTestCase
  test "searching episodes" do
    podcast = create(:podcast)
    create(:episode, podcast:, title: "Episode One")
    create(:episode, podcast:, title: "Episode Two")

    visit podcast_episodes_path(podcast)
    tab_until_focused(:link, "Episode One")
    send_keys [:meta, "k"]
    within :main, "Search" do
      fill_in "Query", with: "episode"
    end

    within :main, %(Search Results for "episode") do
      assert_selector :article, "Episode One", count: 1
      assert_selector :article, "Episode Two", count: 1
    end

    send_keys " two"

    within :main, %(Search Results for "episode two") do
      assert_selector :article, "Episode Two", count: 1
      assert_no_selector :article, "Episode One"
    end
  end

  test "does not add history entries for each keystroke" do
    podcast = create(:podcast)

    visit podcast_episodes_path(podcast)
    click_on "Search"
    within :main, "Search" do
      fill_in "Query", with: "first query"
    end
    within :main, %(Search Results for "first query") do
      fill_in "Query", with: "second query"
    end
    within :main, %(Search Results for "second query") do
      fill_in "Query", with: "third query"
    end
    within :main, %(Search Results for "third query") do
      go_back
    end

    within :main, "Episodes" do
      go_forward
    end

    assert_selector :main, %(Search Results for "third query")
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
