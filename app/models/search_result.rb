class SearchResult < ApplicationModel
  attribute :query, :string
  attribute :episode

  delegate_missing_to :episode
end
