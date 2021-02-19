class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :user, presence: true
  validates :conversation, presence: true
  validates_length_of :content, allow_blank: false
end
