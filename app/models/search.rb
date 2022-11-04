class Search < ApplicationModel
  include Pagy::Backend

  attribute :podcast
  attribute :page
  attribute :query, :string

  def search_results
    page, paginated_episodes = pagy episodes

    paginated_search_results = paginated_episodes.map { |episode| SearchResult.new(episode:, query:) }

    [page, paginated_search_results]
  end

  def episodes
    if query.present?
      podcast.episodes.most_recent_first.containing(query)
    else
      podcast.episodes.none
    end
  end

  private

  def params = {page:}
end
