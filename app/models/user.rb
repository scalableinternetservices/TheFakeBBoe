class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }

  validates :username, presence: true
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }

  has_secure_password

  has_many :users_conversations
  has_many :conversations, through: :users_conversations
  has_many :messages, dependent: :delete_all

  has_many :profiles, dependent: :delete_all

  has_many :user_feed_subscriptions
  has_many :feed_profiles, through: :user_feed_subscriptions, source: :profile
end
