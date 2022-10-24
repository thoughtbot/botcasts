module PodcastImport
  Transform = Struct.new(:feed) do
    def call
      podcast = ImportedPodcast.new(
        author: feed.channel.itunes_author,
        copyright: feed.channel.copyright,
        description: feed.channel.description,
        episode_type: feed.channel.itunes_type || "episodic",
        explicit: boolean_from(feed.channel.itunes_explicit),
        keywords: feed.channel.itunes_keywords,
        itunes_image: feed.channel.itunes_image,
        language: feed.channel.language,
        published_at: feed.channel.pubDate,
        subtitle: feed.channel.itunes_subtitle,
        title: feed.channel.title
      )

      episodes = feed.items.map do |item|
        ImportedEpisode.new(
          duration: interval_from(item.itunes_duration),
          episode_type: item.itunes_episode || "full",
          enclosure: item.enclosure,
          explicit: boolean_from(item.itunes_explicit),
          guid: item.guid.content,
          published_at: item.pubDate,
          season: item.itunes_season,
          subtitle: item.itunes_subtitle,
          title: item.title,
          transcript: item.content_encoded
        )
      end

      [podcast, episodes]
    end

    private

    def boolean_from(string)
      /yes/i.match?(string)
    end

    def interval_from(duration)
      hours = duration.hour.hours
      minutes = duration.minute.minutes
      seconds = duration.second.seconds

      hours + minutes + seconds
    end
  end
end
