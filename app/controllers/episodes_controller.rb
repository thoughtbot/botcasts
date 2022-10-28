class EpisodesController < ApplicationController
  def index
    @podcast = Podcast.find(params[:podcast_id])
    @episodes = @podcast.episodes.most_recent_first
  end

  def show
    @podcast = Podcast.find(params[:podcast_id])
    @episode = @podcast.episodes.find(params[:id])
  end
end
