class SearchResultsController < ApplicationController
  include PodcastScoped

  def index
    @search = @podcast.search(search_params)
    @page, @search_results = @search.search_results
  end

  private

  def search_params
    params.permit!.slice(:page, :query)
  end
end
