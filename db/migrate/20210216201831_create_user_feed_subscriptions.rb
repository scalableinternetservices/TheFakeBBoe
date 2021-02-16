class CreateUserFeedSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_feed_subscriptions do |t|
      t.references :subscriber, null: false, foreign_key: {to_table: :users}
      t.references :subscribed_to_user, null: false, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
