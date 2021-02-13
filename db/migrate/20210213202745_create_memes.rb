class CreateMemes < ActiveRecord::Migration[6.1]
  def change
    create_table :memes do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.binary :img_data

      t.timestamps
    end
  end
end
