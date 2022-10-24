module PodcastImport
  class ImportedPodcast < DelegateClass(Podcast)
    attr_accessor :itunes_image

    def initialize(itunes_image:, **attributes)
      @record = Podcast.new(attributes)
      @itunes_image = itunes_image
      super(@record)
    end
  end
end
