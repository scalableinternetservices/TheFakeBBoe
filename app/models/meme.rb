# https://stackoverflow.com/questions/7167895/rails-whats-a-good-way-to-validate-links-urls
class HttpUrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    unless value.present? && self.class.compliant?(value)
      record.errors.add(attribute, 'is not a valid HTTP URL')
    end
  end
end

class Meme < ApplicationRecord
  belongs_to :profile
  delegate :user, to: :profile
  has_many :meme_tags, dependent: :delete_all
  has_many :tags, through: :meme_tags
  validates :image, http_url: true
  paginates_per 50
  # validates :image, presence: true

  # has_one_attached :image do |attachable|
  #  attachable.variant :thumb, resize: '100x100'
  # end
end
