require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Create Message" do 
    newmessage = Message.new(content: "charles entertainment cheese")
    assert newmessage
  end

end
