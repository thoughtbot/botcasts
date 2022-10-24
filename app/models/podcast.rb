class Podcast < ApplicationRecord
  has_many :episodes, dependent: :destroy

  has_one_attached :image
end
