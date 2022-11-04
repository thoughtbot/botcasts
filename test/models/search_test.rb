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
      title = "An episode"
      podcast = create(:podcast)
      _, included = create_list(:episode, 2, podcast:, title:)
      search = Search.new(podcast:, query: title, page: 1)

      page, results = search.search_results

      assert_equal 2, page.page
      assert_equal 2, page.count
      assert_equal [included], results.map(&:episode)
    end
  end

  def with_pagy_defaults(**overrides)
    defaults = Pagy::DEFAULT.dup

    Pagy::DEFAULT.merge!(overrides)
  ensure
    Pagy::DEFAULT.merge!(defaults)
  end
end
