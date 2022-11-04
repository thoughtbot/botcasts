FactoryBot.define do
  factory :episode do
    association :podcast

    sequence(:title) { "Episode #{_1}: The next one" }
    sequence(:subtitle) { "The one after Episode #{_1 - 1}" }
    sequence(:guid)

    episode_type { "full" }
    duration { 1.hour }
    published_at { 1.day.ago }
    season { 1 }

    transient do
      audio { file_fixture("audio.mp3") }
    end

    after :build do |record, factory|
      if (audio = factory.audio.presence)
        record.audio.attach(io: audio.open, filename: audio.basename)
      end
    end
  end

  factory :podcast do
    sequence(:title) { "botcast #{_1}" }

    author { "thoughtbot" }
    copyright { "© 2022 Giant Robots Smashing Into Other Giant Robots" }
    description { "a podcast by thoughtbot" }
    episode_type { "episodic" }
    keywords { ["design", "development", "product"] }
    language { "en-us" }
    published_at { 1.day.ago }
    subtitle { "it's a good listen" }

    transient do
      image { file_fixture("image.jpg") }
    end

    after :build do |record, factory|
      if (image = factory.image.presence)
        record.image.attach(io: image.open, filename: image.basename)
      end
    end
  end

  factory :user do
  end
end
