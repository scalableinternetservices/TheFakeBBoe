module UserFeedsHelper
    def subscribe_if_not_exists(subscribed_to_profile, subscriber_user)
        if (UserFeedSubscription.exists?(user: subscriber_user, profile: subscribed_to_profile))
            return
        end 
        UserFeedSubscription.create!(user: subscriber_user, profile: subscribed_to_profile)
    end

end
