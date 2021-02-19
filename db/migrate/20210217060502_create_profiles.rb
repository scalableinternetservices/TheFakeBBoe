class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :age
      t.string :location
      t.string :occupation
      t.text :bio

      t.references :follower, foreign_key: { to_table: :profiles }
      t.references :rival, foreign_key: { to_table: :profiles }

      t.timestamps
    end
  end
end
