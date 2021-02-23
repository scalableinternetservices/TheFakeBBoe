require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conversation = conversations(:one)
    @user = users(:one)

    login_as @user
  end

  test "should get index" do
    get conversations_url
    assert_response :success
  end

  test "should get new" do
    get new_conversation_url
    assert_response :success
  end

  test "user should not modify conversations that do not belong to them" do
    get conversation_url(@conversation)
    assert_redirected_to conversations_url

    get edit_conversation_url(@conversation)
    assert_redirected_to conversations_url

    patch conversation_url(@conversation), params: { conversation: { name: @conversation.name } }
    assert_redirected_to conversations_url

    delete conversation_url(@conversation)
    assert_redirected_to conversations_url

    post conversation_add_user_path(@conversation), params: { addUserForm: { username: @user.username } }
    assert_redirected_to conversations_url

    post conversation_write_message_path(@conversation), params: { inputMessage: {  msg: "hello world" } }
    assert_redirected_to conversations_url
  end

  test "should add user to conversation" do
    @conversation.users << @user
    newUser = users(:two)
    conversations_count = @conversation.users.count
    post conversation_add_user_path(@conversation), params: { addUserForm: { username: newUser.username } }
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
    conversations_count = @conversation.messages.count
    @conversation.users << @user
    post conversation_write_message_path(@conversation), params: { inputMessage: {  msg: "hello world" } }
    assert_response :redirect
    assert @conversation.messages.count == conversations_count + 1
  end 

  test "cannot write a blank message to a conversation" do 
    conversations_count = @conversation.messages.count
    @conversation.users << @user
    post conversation_write_message_path(@conversation), params: { inputMessage: { msg: "" } }
    assert_response :redirect
    assert @conversation.messages.count == conversations_count
  end 

  test "should not write a message from user not in conversation" do 
    conversations_count = @conversation.messages.count
    post conversation_write_message_path(@conversation), params: { inputMessage: { msg: "qwertyui" } }
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
    @conversation.users << @user
    get conversation_url(@conversation)
    assert_response :success
  end

  test "should get edit" do
    @conversation.users << @user
    get edit_conversation_url(@conversation)
    assert_response :success
  end

  test "should update conversation" do
    @conversation.users << @user
    patch conversation_url(@conversation), params: { conversation: { name: @conversation.name } }
    assert_redirected_to conversation_url(@conversation)
  end

  test "should destroy conversation" do
    @conversation.users << @user
    assert_difference('Conversation.count', -1) do
      delete conversation_url(@conversation)
    end

    assert_redirected_to conversations_url
  end
end
