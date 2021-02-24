class MoveMemesToProfile < ActiveRecord::Migration[6.1]
  def change
    change_table :memes do |t|
      t.remove_references :user
      t.belongs_to :profile, foreign_key: true
    end

    add_reference :profiles, :memes, foreign_key: true
  end
end
