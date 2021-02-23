class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.boolean :liked, default: false
      t.references :user1, null: false, foreign_key:  { to_table: :users }
      t.references :user2, null: false, foreign_key:  { to_table: :users }

      t.timestamps
    end
  end
end
