require "test_helper"

class UserFeedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_feed = user_feeds(:one)
  end

  test "should get user_feed" do
    p get user_feeds_url
    assert_response :success
  end

  
end
