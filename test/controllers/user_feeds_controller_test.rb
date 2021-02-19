require "test_helper"

class UserFeedsControllerTest < ActionDispatch::IntegrationTest


  test "should get user_feed" do
    get user_feeds_url
    assert_response :success
  end

  
end
