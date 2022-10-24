class CreatePodcastsAndEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :podcasts do |t|
      t.text :author, null: false
      t.text :copyright, null: false
      t.text :description, null: false
      t.text :episode_type, null: false
      t.boolean :explicit, null: false, default: false
      t.text :keywords, null: false, array: true, default: []
      t.text :language, null: false
      t.datetime :published_at, null: false
      t.text :subtitle, null: false, default: ""
      t.text :title, null: false

      t.timestamps

      t.index [:title, :author, :episode_type], unique: true
    end

    create_table :episodes do |t|
      t.belongs_to :podcast, index: true, foreign_key: true

      t.text :title, null: false
      t.text :guid, null: false
      t.datetime :published_at, null: false
      t.text :episode_type, null: false
      t.text :season, null: true
      t.text :subtitle, null: false, default: ""
      t.interval :duration, null: false
      t.boolean :explicit, null: false, default: false

      t.timestamps

      t.index [:podcast_id, :guid], unique: true
    end
  end
end
