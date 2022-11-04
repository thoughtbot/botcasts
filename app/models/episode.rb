class Episode < ApplicationRecord
  belongs_to :podcast

  has_one_attached :audio

  has_rich_text :transcript

  scope :most_recent_first, -> { order published_at: :desc }
  scope :containing, ->(value) {
    if value.present?
      query = "%" + sanitize_sql_like(value) + "%"

      with_rich_text_transcript.left_joins(:rich_text_transcript).where(<<~SQL, query:)
        title ILIKE :query OR subtitle ILIKE :query OR body ILIKE :query
      SQL
    end
  }
end
