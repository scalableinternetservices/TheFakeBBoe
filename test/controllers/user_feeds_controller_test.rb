require "test_helper"

class UserFeedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_feed = user_feeds(:one)
  end

  test "should get index" do
    get user_feeds_url
    assert_response :success
  end

  test "should get new" do
    get new_user_feed_url
    assert_response :success
  end

  test "should create user_feed" do
    assert_difference('UserFeed.count') do
      post user_feeds_url, params: { user_feed: {  } }
    end

    assert_redirected_to user_feed_url(UserFeed.last)
  end

  test "should show user_feed" do
    get user_feed_url(@user_feed)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_feed_url(@user_feed)
    assert_response :success
  end

  test "should update user_feed" do
    patch user_feed_url(@user_feed), params: { user_feed: {  } }
    assert_redirected_to user_feed_url(@user_feed)
  end

  test "should destroy user_feed" do
    assert_difference('UserFeed.count', -1) do
      delete user_feed_url(@user_feed)
    end

    assert_redirected_to user_feeds_url
  end
end
