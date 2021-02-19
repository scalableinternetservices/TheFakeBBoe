require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Create user" do 
    newuser = User.new(username: "charles", password: "entertainment cheese")
    assert newuser
  end
end
