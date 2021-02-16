class User < ApplicationRecord
  has_and_belongs_to_many :conversations,  :join_table => :users_conversations
  has_many :messages, dependent: :delete_all
  has_many :meme
end
