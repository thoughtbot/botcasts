module PodcastImport
  class ImportedEpisode < DelegateClass(Episode)
    attr_accessor :enclosure

    def initialize(enclosure:, **attributes)
      @record = Episode.new(attributes)
      @enclosure = enclosure
      super(@record)
    end
  end
end
