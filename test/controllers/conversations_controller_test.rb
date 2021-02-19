require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conversation = conversations(:one)
  end

  test "should get index" do
    get conversations_url
    assert_response :success
  end

  test "should get new" do
    get new_conversation_url
    assert_response :success
  end

  test "should add user to conversation" do
    newuser = users(:one)
    conversations_count = @conversation.users.count
    post conversation_add_user_path(@conversation), params: { addUserForm: { username: newuser.username } }
    assert_response :redirect
    assert @conversation.users.count == conversations_count + 1
    
  end

  test "should fail to add nonexistant user to conversation" do 
    conversations_count = @conversation.users.count
    post conversation_add_user_path(@conversation), params: { addUserForm: { username: "notarealusername12345678" } }
    assert_response :redirect
    assert @conversation.users.count == conversations_count
  end

  test "should write a message to a conversation" do 
    newuser = users(:one)
    conversations_count = @conversation.messages.count
    @conversation.users << newuser
    post conversation_write_message_path(@conversation), params: { inputMessage: { username: newuser.username, msg: "hello world" } }
    assert_response :redirect
    assert @conversation.messages.count == conversations_count + 1
  end 

  test "cannot write a blank message to a conversation" do 
    newuser = users(:one)
    conversations_count = @conversation.messages.count
    @conversation.users << newuser
    post conversation_write_message_path(@conversation), params: { inputMessage: { username: newuser.username, msg: "" } }
    assert_response :redirect
    assert @conversation.messages.count == conversations_count
  end 

  test "should not write a message from user not in conversation" do 
    newuser = users(:one)
    conversations_count = @conversation.messages.count
    post conversation_write_message_path(@conversation), params: { inputMessage: { username: newuser.username, msg: "qwertyui" } }
    assert_response :redirect
    assert @conversation.messages.count == conversations_count 
  end 

  test "should create conversation" do
    assert_difference('Conversation.count') do
      post conversations_url, params: { conversation: { name: @conversation.name } }
    end

    assert_redirected_to conversation_url(Conversation.last)
  end

  test "should show conversation" do
    get conversation_url(@conversation)
    assert_response :success
  end

  test "should get edit" do
    get edit_conversation_url(@conversation)
    assert_response :success
  end

  test "should update conversation" do
    patch conversation_url(@conversation), params: { conversation: { name: @conversation.name } }
    assert_redirected_to conversation_url(@conversation)
  end

  test "should destroy conversation" do
    assert_difference('Conversation.count', -1) do
      delete conversation_url(@conversation)
    end

    assert_redirected_to conversations_url
  end
end
