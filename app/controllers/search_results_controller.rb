class SearchResultsController < ApplicationController
  include PodcastScoped

  def index
    @search = Search.new(search_params.merge(podcast: @podcast))
    @page, @search_results = @search.search_results
  end

  private

  def search_params
    params.permit!.slice(:page, :query, :turbo_frame)
  end
end
