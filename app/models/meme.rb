class Meme < ApplicationRecord
  belongs_to :user
  has_many :meme_tags
  has_many :tags, through: :meme_tags
  validates :image, presence: true

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end
end
