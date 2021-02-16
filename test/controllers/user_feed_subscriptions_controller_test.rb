require "test_helper"

class UserFeedSubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_feed_subscription = user_feed_subscriptions(:one)
  end

  test "should get index" do
    get user_feed_subscriptions_url
    assert_response :success
  end

  test "should get new" do
    get new_user_feed_subscription_url
    assert_response :success
  end

  test "should create user_feed_subscription" do
    assert_difference('UserFeedSubscription.count') do
      post user_feed_subscriptions_url, params: { user_feed_subscription: {  } }
    end

    assert_redirected_to user_feed_subscription_url(UserFeedSubscription.last)
  end

  test "should show user_feed_subscription" do
    get user_feed_subscription_url(@user_feed_subscription)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_feed_subscription_url(@user_feed_subscription)
    assert_response :success
  end

  test "should update user_feed_subscription" do
    patch user_feed_subscription_url(@user_feed_subscription), params: { user_feed_subscription: {  } }
    assert_redirected_to user_feed_subscription_url(@user_feed_subscription)
  end

  test "should destroy user_feed_subscription" do
    assert_difference('UserFeedSubscription.count', -1) do
      delete user_feed_subscription_url(@user_feed_subscription)
    end

    assert_redirected_to user_feed_subscriptions_url
  end
end
