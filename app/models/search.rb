class Search < ApplicationModel
  include Pagy::Backend

  attribute :podcast
  attribute :page
  attribute :query, :string

  def search_results
    page, paginated_episodes = pagy episodes

    [page, paginated_episodes.map { SearchResult.new(episode: _1, search: self) }]
  end

  def episodes
    if query.present?
      podcast.episodes.most_recent_first.containing(query)
    else
      podcast.episodes.none
    end
  end

  def to_hash
    {query:, **params}.compact_blank
  end

  private

  def params = {page:}
end
