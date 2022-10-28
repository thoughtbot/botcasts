require "test_helper"

module Episodes
  class IndexTest < ActionDispatch::IntegrationTest
    test "renders a list of the Podcast's Episodes" do
      episode = create(:episode)

      get podcast_episodes_path(episode.podcast)

      within :main, "Episodes" do
        within :article, episode.title do
          assert_selector :element, "time", datetime: episode.published_at.to_date.iso8601
          assert_text episode.subtitle
          assert_link episode.title, href: podcast_episode_path(episode.podcast, episode)
          assert_selector :element, "form", action: podcast_episode_path(episode.podcast, episode), method: false,
            "data-action": "submit->application#preventDefault:reload",
            "data-turbo-frame": "audio" do |form|
            form.has_button?("Play episode #{episode.title}", text: "Listen") do |button|
              button.matches_selector? :element, "button",
                "data-controller": /play-button/,
                "data-play-button-player-outlet": "#" + dom_id(episode, :audio),
                "data-action": /click->play-button#toggle/
            end
          end
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
        assert_selector :section, "About", text: episode.podcast.description, count: 1
      end
      within :contentinfo do
        assert_selector :section, "About", text: episode.podcast.description, count: 1
      end
    end

    test "renders a placeholder for the player" do
      episode = create(:episode)

      get podcast_episodes_path(episode.podcast)

      within :element, id: "player", "data-turbo-permanent": true do
        assert_selector :element, "turbo-frame", id: "audio", target: "_top"
      end
    end

    test "provides navigation to the Search page" do
      episode = create(:episode)

      get podcast_episodes_path(episode.podcast)

      within :element, "data-controller": /hotkey/ do
        within :banner do
          within :element, "a", text: "Search", href: podcast_search_results_path(episode.podcast),
            "aria-keyshortcuts": "Meta+k",
            "data-hotkey-target": "shortcut" do
            assert_selector :element, "kbd", text: "⌘ K"
          end
        end
      end
    end
  end

  class ShowTest < ActionDispatch::IntegrationTest
    test "renders the Episode" do
      episode = create(:episode, :with_transcript)

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
        assert_selector :element, "form", action: false, method: false,
          "data-action": "submit->application#preventDefault:reload",
          "data-turbo-frame": "audio" do |form|
            form.has_selector? :element, "button", text: "Play",
              "data-controller": /play-button/,
              "data-play-button-player-outlet": "#" + dom_id(episode, :audio),
              "data-action": /click->play-button#toggle/
          end
      end
      within :main do
        within :element, "turbo-frame", id: "audio", target: "_top" do
          assert_selector :element, "audio", id: dom_id(episode, :audio), controls: true
        end
      end
    end

    test "renders the Episode within the context of their Podcast" do
      episode = create(:episode)

      get podcast_episode_path(episode.podcast, episode)

      within :banner do
        assert_link episode.podcast.title, href: podcast_episodes_path(episode.podcast)
        assert_link text: episode.podcast.title, href: podcast_episodes_path(episode.podcast)
        assert_selector :section, "About", text: episode.podcast.description
      end
      within :contentinfo do
        assert_selector :section, "About", text: episode.podcast.description
      end
    end

    test "renders the Episode's player" do
      episode = create(:episode)

      get podcast_episode_path(episode.podcast, episode)

      within :element, id: "player", "data-turbo-permanent": true do
        within :element, "turbo-frame", id: "audio", target: "_top" do
          assert_link episode.title, href: podcast_episode_path(episode.podcast, episode)
          assert_selector :element, "audio", id: dom_id(episode, :audio), controls: true
        end
      end
    end
  end
end
