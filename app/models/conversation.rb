class Conversation < ApplicationRecord
  has_many :users_conversations, dependent: :delete_all
  has_many :users, through: :users_conversations
  has_many :messages, dependent: :delete_all
  paginates_per 10
end
