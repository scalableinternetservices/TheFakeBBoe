class User < ApplicationRecord
<<<<<<< HEAD
  has_many :meme
=======
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }

  validates :username, presence: true
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }

  has_secure_password

  has_and_belongs_to_many :conversations, join_table: :users_conversations
  has_many :messages, dependent: :delete_all
  has_many :meme
  has_many :profile
>>>>>>> db78c8d9f969ba3bc675b30b6317f36a853672d5
end
