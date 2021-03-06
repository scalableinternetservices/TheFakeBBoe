class CreateMemeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :meme_tags, id: false do |t|
      t.belongs_to :tag, foreign_key: true, null: false
      t.belongs_to :meme, foreign_key: true, null: false
      t.timestamps
    end
  end
end
