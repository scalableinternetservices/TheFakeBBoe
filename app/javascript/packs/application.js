// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require("jquery")

Rails.start()
Turbolinks.start()
ActiveStorage.start()


import chatRoomChannel from "../channels/chat_room_channel";

$(document).on('turbolinks:load', function () {
    $("#send_message").on('submit', function (e) {
        
        e.preventDefault();
        let message = $('#message').val();
        let conversation_id = $('#conversation_id').val();
        console.log("Submit", message);
        if (message.length > 0) {
            chatRoomChannel.speak(message);
            $('#message').val('')
            var url = $('#send_message').attr('action');

            $.post(url, { data: message })
            // $.ajax({
            //     type: "POST",
            //     url: "/conversations/" + conversation_id + "/writeMessage" 
            // });
        }
    });
})
