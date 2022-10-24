module PodcastImport
  Extract = Struct.new(:url) do
    def call
      uri = URI(url)
      rss = Net::HTTP.get(uri)

      RSS::Parser.parse(rss)
    end
  end
end
