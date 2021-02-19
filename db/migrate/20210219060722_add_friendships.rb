class AddFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships, id: false do |t|
      t.belongs_to :profile
      t.belongs_to :friend, class_name: "Profile"
    end
  end
end
