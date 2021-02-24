class CreateMemeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :memes_tags do |t|
      t.belongs_to :tag
      t.belongs_to :meme
      t.timestamps
    end
  end
end
