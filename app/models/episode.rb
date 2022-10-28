class Episode < ApplicationRecord
  belongs_to :podcast

  has_one_attached :audio

  has_rich_text :transcript

  scope :most_recent_first, -> { order published_at: :desc }
end
