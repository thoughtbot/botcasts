class PodcastsController < ApplicationController
  def index
    @podcasts = Podcast.all

    redirect_to podcast_episodes_url(@podcasts.first)
  end
end
