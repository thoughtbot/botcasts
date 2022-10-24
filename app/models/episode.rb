class Episode < ApplicationRecord
  belongs_to :podcast

  has_one_attached :audio

  has_rich_text :transcript
end
