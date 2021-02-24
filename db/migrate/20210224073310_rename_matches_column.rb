class RenameMatchesColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :matches, :user1_id, :sender_id
    rename_column :matches, :user2_id, :receiver_id
  end
end
