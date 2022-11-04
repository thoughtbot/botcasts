class AddSearchableIndicesToActionTextRichTextsAndEpisodes < ActiveRecord::Migration[7.1]
  def change
    change_table :action_text_rich_texts do |t|
      t.text :body_plain_text
      t.index "to_tsvector('english', body_plain_text)", using: :gin, name: "body_tsvector_idx"
    end

    change_table :episodes do |t|
      t.index :title
      t.index :subtitle, where: "NOT NULL"
    end
  end
end
