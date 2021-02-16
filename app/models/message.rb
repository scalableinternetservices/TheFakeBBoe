class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates_presence_of :user_id
  validates_presence_of :conversation_id
end
