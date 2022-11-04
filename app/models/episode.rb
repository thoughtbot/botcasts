class Episode < ApplicationRecord
  belongs_to :podcast

  has_one_attached :audio

  has_rich_text :transcript

  scope :most_recent_first, -> { order published_at: :desc }
  scope :websearch_transcript, ->(value) {
    joins(:rich_text_transcript).merge ActionText::RichText.websearch_body(value)
  }
  scope :containing, ->(value) {
    if value.present?
      fulltext_search = websearch_transcript(value).select(:id)

      where <<~SQL, query: "%" + sanitize_sql_like(value) + "%"
        title ILIKE :query OR subtitle ILIKE :query OR id IN (#{fulltext_search.to_sql})
      SQL
    end
  }
end
