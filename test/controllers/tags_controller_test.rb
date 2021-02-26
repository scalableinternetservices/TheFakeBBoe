require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meme = memes(:one)
    cat_file = fixture_file_upload('cat.jpg', 'image/jpg')
    @meme.image.attach(cat_file)
    @tag = tags(:cat)
  end

  test "should get index" do
    get tags_url
    assert_response :success
  end

  test "should show tag" do
    get tag_url(@tag)
    assert_response :success
  end

  test "should get tag browse" do
    get "/memes/browse/#{@tag.name}"
    assert_response :success
  end
end
