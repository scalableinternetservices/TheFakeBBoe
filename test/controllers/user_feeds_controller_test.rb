require "test_helper"

class UserFeedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meme = memes(:two)
    dog_file = fixture_file_upload('dog.jpg', 'image/jpg')
    @meme.image.attach(dog_file)
  end

  test "should get user_feed" do
    login_as users(:one)
    get user_feeds_url
    assert_response :success
  end

  
end
