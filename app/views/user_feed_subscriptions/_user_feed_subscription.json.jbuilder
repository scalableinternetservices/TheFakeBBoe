json.extract! user_feed_subscription, :id, :created_at, :updated_at
json.url user_feed_subscription_url(user_feed_subscription, format: :json)
