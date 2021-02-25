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
      let current_user = sessionStorage.getItem('user_id')
      console.log("current_user", current_user)
      let msg_class = data.username === current_user ? "sent" : "received"
      if (msg_class === "sent")
        $('#messages').append(`<p class='${msg_class}'>` + data.message + '</p>')
      else
        $('#messages').append(`<p class='${msg_class}'>` + data.username + ": " + data.message + '</p>')
      
      $("#messages").animate({ scrollTop: $('#messages').prop("scrollHeight") }, 1000);
    } 
  },

  speak(message, username) {
    this.perform('speak', { message, username })
  }
});

export default chatRoomChannel;