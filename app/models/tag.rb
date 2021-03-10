class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :meme_tags, dependent: :destroy
  has_many :memes, through: :meme_tags

  paginates_per 20
end
