class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def chatroom
    Conversation.find(params[:chatroom_id])
  end

end
