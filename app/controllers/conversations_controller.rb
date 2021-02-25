class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[ show edit update destroy addUser writeMessage ]
  before_action :require_login
  before_action :check_user, only: %i[ show edit update destroy addUser writeMessage ]

  # GET /conversations or /conversations.json
  def index
    @conversations = current_user.conversations
  end

  # GET /conversations/1 or /conversations/1.json
  def show
    @users = @conversation.users
    @messages = @conversation.messages

  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations or /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)
    # p "CURREN T USER", current_user
    # p "Conversation useres", @conversation.users
    
    respond_to do |format|
      if @conversation.save
        @conversation.users << current_user
        format.html { redirect_to @conversation, notice: "Conversation was successfully created." }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1 or /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: "Conversation was successfully updated." }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1 or /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: "Conversation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def addUser
    # First, check if the user exists
    username = params[:addUserForm][:username]
    userToAdd = User.find_by_username(username)
    if (userToAdd != nil and not @conversation.users.include?(userToAdd)) 
      
      userToAdd.conversations << @conversation
      # @conversation.users << userToAdd
      

      respond_to do |format|
        format.html { redirect_to @conversation, notice: "User was successfully added to conversation" }
        format.json { render :show, status: :ok, location: @conversation }
      end
    else
      # User does not exist
      @conversation.errors.add(:users, "Invalid username")
      respond_to do |format|
        format.html { redirect_to @conversation, notice: "Invalid username" }
        format.json { render :show, status:  :unprocessable_entity, location: @conversation }
      end
    end
  end


  def writeMessage
    p "PARAMS:", params

    content = params[:data]
    newMessage = Message.new(:content => content, :username => current_user.username)

    if not @conversation.users.include?(current_user) # contains userToAdd
      # User not authorized to add a message to this conversation
      @conversation.errors.add(:users, "User does not belong to conversation")
      # respond_to do |format|
      #   format.html { redirect_to @conversation, notice: "User is not part of this conversation" }
      #   format.json { render :show, status: :unprocessable_entity, location: @conversation }
      # end

      return
    end

    newMessage.user_id = current_user.id
    newMessage.conversation_id = @conversation.id
    newMessage.save
    # respond_to do |format|
    #   if newMessage.save             
    #     format.html { redirect_to @conversation, notice: "Message written" }
    #     format.json { render :show, status: :ok, location: @conversation }
    #   else
    #     @conversation.errors.add(:users, "Invalid message write")
    #     format.html { redirect_to @conversation, notice: "Message not written" }
    #     format.json { render :show, status: :unprocessable_entity, location: @conversation }
    #   end
    # end
  

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.require(:conversation).permit(:name)
    end

    def check_user
      # Check that the current user owns the conversation. Otherwise redirect
      if not @conversation.users.include?(current_user)
        redirect_to conversations_url
      end
    end
end
