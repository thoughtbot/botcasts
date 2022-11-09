require "application_system_test_case"

class InfiniteScrollTest < ApplicationSystemTestCase
  test "scrolling loads the next page of episodes" do
    with_pagy_defaults items: 10 do
      podcast = create(:podcast)
      top_episode, bottom_episode, * = create_list(:episode, 11, podcast:)

      visit podcast_episodes_path(podcast)

      within :main do
        assert_no_selector :article, top_episode.title
        assert_link "Load older episodes"

        scroll_to find :article, bottom_episode.title

        assert_no_link "Load older episodes"
        assert_selector :article, top_episode.title
        assert_equal podcast_episodes_url(podcast, page: 2), current_url
      end
    end
  end

  test "load the previous page of episodes from the link" do
    with_pagy_defaults items: 10 do
      podcast = create(:podcast)
      top_episode, bottom_episode, * = create_list(:episode, 11, podcast:)

      visit podcast_episodes_path(podcast, page: 2)

      within :main do
        assert_link "Load newer episodes"
        assert_selector :article, top_episode.title
        assert_no_link "Load older episodes"

        click_on "Load newer episodes"

        assert_selector :article, bottom_episode.title
        assert_no_selector :article, top_episode.title
        assert_equal podcast_episodes_url(podcast, page: 1), current_url
      end
    end
  end
end
