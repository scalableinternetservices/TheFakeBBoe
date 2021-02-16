class User < ApplicationRecord
  has_many :meme
  has_and_belongs_to_many :conversations
end
