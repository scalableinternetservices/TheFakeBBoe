class AddUserConversationAssociation < ActiveRecord::Migration[6.1]
  def change

    create_table :users_conversations, id: false do |t|
      t.belongs_to :user
      t.belongs_to :conversation
    end
  end
end
