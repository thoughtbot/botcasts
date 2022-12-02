class SearchResult < ApplicationModel
  attribute :episode
  attribute :search

  delegate :query, to: :search
  delegate_missing_to :episode

  def to_partial_path
    if search.turbo_frame.present?
      "search_results/options/search_result"
    else
      super
    end
  end
end
