class UserFeedSubscription < ApplicationRecord
    belongs_to :subscriber, class_name: 'User', foreign_key: 'subscriber_id', required: true
    belongs_to :subscribed_to_user, class_name: 'User', foreign_key: 'subscribed_to_user_id', required: true
end
