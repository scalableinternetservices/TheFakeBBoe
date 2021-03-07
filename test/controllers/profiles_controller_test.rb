require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:one)
    @user = users(:one)
    # cat_file = fixture_file_upload('cat.jpg', 'image/jpg')
    # @meme.image.attach(cat_file)
    @meme = memes(:one)
    login_as @user
  end

  test 'should get index' do
    get profiles_url
    assert_response :success
  end

  test 'should get new' do
    get new_profile_url
    assert_response :success
  end

  test 'should create profile' do
    assert_difference('Profile.count') do
      post profiles_url, params: { profile: { name: @profile.name } }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test 'should show profile' do
    @user.profiles << @profile
    get profile_url(@profile)
    assert_response :success
  end

  test 'should get edit' do
    @user.profiles << @profile
    get edit_profile_url(@profile)
    assert_response :success
  end

  test 'should update profile' do
    @user.profiles << @profile
    patch profile_url(@profile), params: { profile: { name: @profile.name } }
    assert_redirected_to profile_url(@profile)
  end

  test 'should destroy profile' do
    @user.profiles << @profile
    assert_difference('Profile.count', -1) do
      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end
