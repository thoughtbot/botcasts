require "test_helper"

class SearchTest < ActiveSupport::TestCase
  test "#search_results paginates a collection of SearchResult instances" do
    title = "An episode"
    podcast = create(:podcast)
    records = create_list(:episode, 2, podcast:, title:)
    search = Search.new(podcast:, query: title)

    page, results = search.search_results

    assert_equal 1, page.page
    assert_equal 2, page.count
    assert_equal records.to_set, results.map(&:episode).to_set
    results.each { assert_kind_of SearchResult, _1 }
  end

  test "#search_results incorporates page: attribute into pagination" do
    with_pagy_defaults items: 1 do
      podcast = create(:podcast)
      create(:episode, podcast:, title: "minute-old match", published_at: 1.minute.ago)
      create(:episode, podcast:, title: "week-old match", published_at: 1.day.ago)
      search = Search.new(podcast:, query: "match", page: 2)

      page, results = search.search_results

      assert_equal 2, page.page
      assert_equal 2, page.count
      assert_equal ["week-old match"], results.pluck(:title)
    end
  end
end
