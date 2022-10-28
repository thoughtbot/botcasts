require "application_system_test_case"

class AudioPlayerTest < ApplicationSystemTestCase
  test "play an Episode from its page" do
    episode = create(:episode)
    audio_filename = /#{episode.audio.filename}\Z/

    visit podcast_episode_path(episode.podcast, episode)
    click_on "Play", aria: {pressed: false}
    click_on "Play", aria: {pressed: false}

    assert_button "Pause", aria: {pressed: true}
    assert_audio audio_filename, playing: true

    click_link episode.podcast.title, match: :first

    assert_audio audio_filename, playing: true

    click_button "Pause episode #{episode.title}", aria: {pressed: true}

    assert_audio audio_filename, played: true, paused: true
  end

  test "play an Episode from the collection" do
    episode = create(:episode)
    audio_filename = /#{episode.audio.filename}\Z/

    visit podcast_episodes_path(episode.podcast)
    click_button "Play episode #{episode.title}"
    click_button "Play episode #{episode.title}"

    assert_button "Pause episode #{episode.title}", aria: {pressed: true}
    assert_audio audio_filename, playing: true

    within(:article, episode.title) { click_link "Show notes" }

    assert_audio audio_filename, playing: true

    click_button "Pause", aria: {pressed: true}

    assert_audio audio_filename, played: true, paused: true
  end
end
