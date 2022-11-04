module PodcastScoped
  extend ActiveSupport::Concern

  included do
    before_action :scope_by_podcast
  end

  def scope_by_podcast
    if (podcast_id = params[:podcast_id])
      set_podcast(podcast_id)
    end
  end

  def set_podcast(podcast_id)
    @podcast = Podcast.find(podcast_id)
  end
end
