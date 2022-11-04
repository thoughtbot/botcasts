class SearchResult < ApplicationModel
  attribute :episode
  attribute :search

  delegate :query, to: :search
  delegate_missing_to :episode
end
