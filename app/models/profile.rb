class Profile < ApplicationRecord
  has_and_belongs_to_many :friends, class_name: 'Profile', join_table: :friendships

  belongs_to :user
  has_many :memes, dependent: :delete_all
end
