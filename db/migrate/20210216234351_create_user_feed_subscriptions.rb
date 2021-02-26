class CreateUserFeedSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_feed_subscriptions, id: false do |t|
      t.belongs_to :user
      t.belongs_to :profile
      t.timestamps
    end
  end
end
