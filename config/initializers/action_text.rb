ActiveSupport.on_load :action_text_rich_text do
  attr_readonly :body_plain_text

  scope :websearch_body, ->(websearch) { where <<~SQL, websearch: }
    to_tsvector('english', body_plain_text) @@ websearch_to_tsquery(:websearch)
  SQL

  def body=(...)
    super

    write_attribute :body_plain_text, body.try(:to_plain_text)
  end

  def to_plain_text
    body_plain_text
  end
end
