require "test_helper"

class EpisodeTest < ActiveSupport::TestCase
  test ".containing searches episodes.title" do
    included = create(:episode, title: "a match")
    create(:episode, title: "ignored")

    containing = Episode.containing("MaTch")

    assert_equal [included], containing
  end

  test ".containing searches episodes.subtitle" do
    included = create(:episode, subtitle: "a match")
    create(:episode, subtitle: "ignored")

    containing = Episode.containing("MaTch")

    assert_equal [included], containing
  end

  test ".containing searches an Episode's action_text_rich_texts.content transcript" do
    included = create(:episode, transcript: "a match")
    create(:episode, transcript: "ignored")

    containing = Episode.containing("MaTch")

    assert_equal [included], containing
  end

  test ".containing returns all results when the query is nil" do
    records = [
      create(:episode, title: "a match"),
      create(:episode, title: "ignored")
    ]

    containing = Episode.containing(nil)

    assert_equal records.pluck(:title).to_set, containing.pluck(:title).to_set
  end

  test ".containing returns all results when the query is blank" do
    records = [
      create(:episode, title: "a match"),
      create(:episode, title: "ignored")
    ]

    containing = Episode.containing("")

    assert_equal records.pluck(:title).to_set, containing.pluck(:title).to_set
  end
end
