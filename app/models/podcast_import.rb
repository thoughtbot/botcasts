module PodcastImport
  def self.call(url)
    feed = Extract.new(url).call
    podcast, episodes = Transform.new(feed).call
    Load.new(podcast, episodes).call
  end
end
