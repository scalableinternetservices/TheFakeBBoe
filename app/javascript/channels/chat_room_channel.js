import consumer from "./consumer"

const chatRoomChannel = consumer.subscriptions.create("ChatRoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the chat room")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {

    if (data.message) {
      let current_name = sessionStorage.getItem('chat_room_name')
      let msg_class = data.sent_by === current_name ? "sent" : "received"
      $('#messages').append(`<p class='${msg_class}'>` + data.message + '</p>')
    } 
  },

  speak(message) {
    let name = sessionStorage.getItem('chat_room_name')
    this.perform('speak', { message, name })
  }
});

export default chatRoomChannel;