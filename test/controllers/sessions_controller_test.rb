require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get login page" do
    get login_url
    assert_response :success
  end

  test "should be able to log in" do
    login_as @user, 'password'
    assert_redirected_to root_url
    assert_equal @user.id, session[:user_id]
  end

  test "should be denied login when password incorrect" do
    login_as @user, "badpassword"
    assert_response :unauthorized
  end
end
