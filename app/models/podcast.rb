class Podcast < ApplicationRecord
  has_many :episodes, dependent: :destroy

  has_one_attached :image

  def search(attributes = {})
    Search.new(podcast: self, **attributes)
  end
end
