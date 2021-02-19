json.extract! user_feed, :id, :created_at, :updated_at
json.url user_feed_url(user_feed, format: :json)
