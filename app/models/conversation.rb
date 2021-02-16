class Conversation < ApplicationRecord
    has_and_belongs_to_many :users,  :join_table => :users_conversations
    has_many :messages, dependent: :delete_all
end
