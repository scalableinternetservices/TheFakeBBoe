class Meme < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags, join_table: :memes_tags
  validates :image, presence: true

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end
end
