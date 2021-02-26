class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :meme_tags
  has_many :memes, through: :meme_tags
end
