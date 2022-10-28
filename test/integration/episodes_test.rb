require "test_helper"

class EpisodesTest < ActionDispatch::IntegrationTest
  class IndexTest < ActionDispatch::IntegrationTest
    test "renders a list of the Podcast's Episodes" do
      episode = create(:episode)

      get podcast_episodes_path(episode.podcast)

      within :main, "Episodes" do
        within :article, episode.title do
          assert_selector :element, "time", datetime: episode.published_at.to_date.iso8601
          assert_text episode.subtitle
          assert_link episode.title, href: podcast_episode_path(episode.podcast, episode)
          assert_form action: podcast_episode_path(episode.podcast, episode), method: false, buttons: [["Play episode #{episode.title}", text: "Listen"]]
          assert_link "Show notes for episode #{episode.title}", text: "Show notes", href: podcast_episode_path(episode.podcast, episode)
        end
      end
    end

    test "renders the Episodes within the context of their Podcast" do
      episode = create(:episode)

      get podcast_episodes_path(episode.podcast)

      within :banner do
        assert_link episode.podcast.title, href: podcast_episodes_path(episode.podcast)
        assert_link text: episode.podcast.title, href: podcast_episodes_path(episode.podcast)
        assert_link "Spotify"
        assert_link "Apple Podcast"
        assert_link "Overcast"
        assert_link "RSS Feed"
        assert_selector :section, "About", text: episode.podcast.description, count: 1
      end
      within :contentinfo do
        assert_selector :section, "About", text: episode.podcast.description, count: 1
      end
    end
  end

  class ShowTest < ActionDispatch::IntegrationTest
    test "renders the Episode" do
      episode = create(:episode)

      get podcast_episode_path(episode.podcast, episode)

      within :main, episode.title do
        within :article do
          assert_selector :element, "time", datetime: episode.published_at.to_date.iso8601
          assert_text episode.subtitle
          assert_text episode.transcript.to_plain_text
        end
      end
    end

    test "renders the audio player as paused" do
      episode = create(:episode)

      get podcast_episode_path(episode.podcast, episode)

      within :article do
        assert_form action: false, method: false, buttons: ["Play"]
      end
      within :main do
        assert_selector :element, "audio"
      end
    end

    test "renders the Episode within the context of their Podcast" do
      episode = create(:episode)

      get podcast_episode_path(episode.podcast, episode)

      within :banner do
        assert_link episode.podcast.title, href: podcast_episodes_path(episode.podcast)
        assert_link text: episode.podcast.title, href: podcast_episodes_path(episode.podcast)
        assert_link "Spotify"
        assert_link "Apple Podcast"
        assert_link "Overcast"
        assert_link "RSS Feed"
        assert_selector :section, "About", text: episode.podcast.description
      end
      within :contentinfo do
        assert_selector :section, "About", text: episode.podcast.description
      end
    end
  end
end
