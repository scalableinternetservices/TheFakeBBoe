require "test_helper"

class MemesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meme = memes(:one)
    cat_file = fixture_file_upload('cat.jpg', 'image/jpg')
    @meme.image.attach(cat_file)
  end

  test "should get index" do
    get memes_url
    assert_response :success
  end

  test "should get new" do
    get new_meme_url
    assert_response :success
  end

  test "should create meme" do
    assert_difference('Meme.count') do
      cat_file = fixture_file_upload('cat.jpg', 'image/jpg')
      post memes_url, params: { meme: { user_id: 1, title: 'my_meme', image: cat_file } }
    end

    assert_redirected_to meme_url(Meme.last)
  end

  test "should fail to create meme when no file is provided" do
    post memes_url, params: { meme: { title: 'my_meme' } }
    assert_response :unprocessable_entity
  end

  test "should show meme" do
    get meme_url(@meme)
    assert_response :success
  end

  test "should get edit" do
    get edit_meme_url(@meme)
    assert_response :success
  end

  test "should update meme" do
    dog_file = fixture_file_upload('dog.jpg', 'image/jpg')
    patch meme_url(@meme), params: { meme: { title: 'dog_meme', image: dog_file } }
    assert_redirected_to meme_url(@meme)
    @meme.reload
    assert_equal 'dog_meme', @meme.title
  end

  test "should destroy meme" do
    assert_difference('Meme.count', -1) do
      delete meme_url(@meme)
    end

    assert :success
  end
end
