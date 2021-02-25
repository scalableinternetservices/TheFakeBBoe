class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chat_room_channel_#{params[:conversation_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast "chat_room_channel_#{params[:conversation_id]}", message: data["message"], username: data["username"]
  end

end
