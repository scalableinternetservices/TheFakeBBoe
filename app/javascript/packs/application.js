// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

require("jquery")

Rails.start()
Turbolinks.start()
ActiveStorage.start()
import consumer from '../channels/consumer'

$(document).on('turbolinks:load', function () {
    
    $("#send_message").on('submit', function (e) {
        e.preventDefault();
        let message = $('#message').val();
        if (message.length > 0) {
            var url = $('#send_message').attr('action');
            $.post(url, { data: message })
            $('#message').val('')
        }
    });
})

$(document).on('turbolinks:load', function () {
    if (this.subscription) {
        consumer.subscriptions.remove(this.subscription)
        consumer.disconnect();
        this.subscription = null;
    }

    if ($('#chatroom').attr('data-chatroom-id')) {
        var sub = consumer.subscriptions.create({
            channel: "ChatRoomChannel",
            chatroom_id: $('#chatroom').attr('data-chatroom-id')
        }, {
            connected() {
                // Called when the subscription is ready for use on the server
                // console.log("Connected to the chat room")
            },

            disconnected() {
                // Called when the subscription has been terminated by the server
                // console.log("Disconnected from chatroom")
            },

            received(data) {
                if (data.message) {
                    if (userName === data.username) {
                        $('#messages').append(`<p class='sent'>` + data.message + '</p>')
                    }
                    else {
                        $('#messages').append(`<p class='received'>` + data.username + ": " + data.message + '</p>')
                    }

                    $("#messages").animate({ scrollTop: $('#messages').prop("scrollHeight") }, 1000);
                }
            },
        });
        this.subscription = sub;
    }
});
