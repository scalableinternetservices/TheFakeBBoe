class CreateMemeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :meme_tags, id: false do |t|
      t.belongs_to :tag
      t.belongs_to :meme
      t.timestamps
    end
  end
end
