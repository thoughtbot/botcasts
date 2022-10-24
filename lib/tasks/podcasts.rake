task "podcasts:import" => :environment do
  [
    "https://feeds.fireside.fm/giantrobots/rss",
    "https://feeds.fireside.fm/bikeshed/rss"
  ].each { |url| PodcastImport.call(url) }
end

task "db:seed" => "podcasts:import"
