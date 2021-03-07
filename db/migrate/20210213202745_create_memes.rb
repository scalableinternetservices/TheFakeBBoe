class CreateMemes < ActiveRecord::Migration[6.1]
  def change
    create_table :memes do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.string :image

      t.timestamps
    end
  end
end
