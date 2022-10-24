module PodcastImport
  Load = Struct.new(:podcast, :episodes) do
    def call
      Podcast.transaction do
        Podcast.destroy_by(podcast.slice(:title, :author, :episode_type))

        podcast.update!(episodes: episodes.map(&:to_model))

        DownloadAttachmentJob.perform_later(podcast.to_model, :image, podcast.itunes_image.href)

        episodes.each do |episode|
          DownloadAttachmentJob.perform_later(episode.to_model, :audio, episode.enclosure.url)
        end
      end

      [podcast, episodes]
    end
  end
end
