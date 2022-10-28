require "test_helper"

module SearchResults
  class IndexTest < ActionDispatch::IntegrationTest
    test "renders a prompt when the query is blank" do
      podcast = create(:podcast)

      get podcast_search_results_path(podcast)

      within :main, "Search" do
        within :element, "form", method: "get", action: false do
          assert_field "Query", type: "text", described_by: "Search for episodes by their title, subtitle, or transcript."
          assert_button "Search"
        end
      end
    end

    test "renders a prompt when there are no results" do
      podcast = create(:podcast)
      query = "term"

      get podcast_search_results_path(podcast), params: {query:}

      within :main, %(Search Results for "#{query}") do
        within :element, "form", method: "get", action: false do
          assert_field "Query", type: "text", with: query
          assert_button "Search"
        end

        assert_text %(We couldn't find any episodes matching "#{query}".)
      end
    end

    test "renders a list of the Podcast's Episodes that match the query" do
      podcast = create(:podcast)
      included = create(:episode, podcast:, title: "A title match", subtitle: "A subtitle match", transcript: "A matching transcript")
      excluded = create(:episode, podcast:, title: "ignored")
      query = "match"

      get podcast_search_results_path(podcast), params: {query:}

      within :main, %(Search Results for "match") do
        assert_no_selector :article, excluded.title

        within :article, included.title do
          within :link, text: included.title do
            assert_selector "mark", text: query
          end
          within "p", text: included.subtitle do
            assert_selector "mark", text: query
          end
          within "p", text: included.transcript.to_plain_text do
            assert_selector "mark", text: query
          end
          assert_link included.title, href: podcast_episode_path(podcast, included)
          assert_selector :element, "form", action: podcast_episode_path(podcast, included), method: false,
            "data-action": "submit->application#preventDefault:reload",
            "data-turbo-frame": "audio" do |form|
              form.has_button?("Play episode #{included.title}", text: "Listen") do |button|
                button.matches_selector? :element, "button",
                  "data-controller": /play-button/,
                  "data-play-button-player-outlet": "#" + dom_id(included, :audio),
                  "data-action": /click->play-button#toggle/
              end
            end
          assert_link "Show notes for episode #{included.title}", text: "Show notes", href: podcast_episode_path(podcast, included)
        end
      end
    end

    test "renders an empty placeholder for the player" do
      podcast = create(:podcast)

      get podcast_search_results_path(podcast)

      within :element, id: "player", "data-turbo-permanent": true do
        assert_selector :element, "turbo-frame", id: "audio", target: "_top"
      end
    end
  end
end
