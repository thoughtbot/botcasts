class EpisodesController < ApplicationController
  include PodcastScoped

  def index
    @page, @episodes = pagy @podcast.episodes.most_recent_first
  end

  def show
    @episode = @podcast.episodes.find(params[:id])
  end
end
