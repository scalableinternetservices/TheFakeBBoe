require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Create Message" do 
    newmessage = Message.new(content: "charles entertainment cheese")
    p newmessage
    assert newmessage
  end
end
