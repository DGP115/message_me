# frozen_string_literal: true

# This class handles processing of new messages
class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = Message.new(whitelist_message_params)
    message.user_id = current_user.id
    if message.save
      # Parsing the statement below:
      # - "added_message" is the tag in the hash that is passed to chatroom_channel.js
      #    to be broadcast.
      # - "message" is what is received from the browser as the new message
      #    (and instantiated above).
      # - "message_render" is a private method that renders the message partial and thus
      #    ensures the new message is appended to the chatroom and styled accordingly
      #    [in chatroon/index.html.erb].
      #       .... Why we do that in the argument to the ActionCable broadcast, I don't know...
      #  - The call to ActionCable.server.broadcast sends added_message out on the chatroom channel.
      ActionCable.server.broadcast 'chatroom_channel', { added_message: message_render(message) }
    else

      # Error trapping
      # Because the save returned false, the error trapping on the "new" page
      # will display the errors
      flash[:error] = 'Message was not saved'
      render 'chatroom/index', status: :unprocessable_entity

    end
  end

  private

  def whitelist_message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    #  Below is an example of a call to render a View from a Controller.
    #  The locals hash passess to parial 'messages/_message.html.erb' the object message
    #  in a hash, tagged as message:
    render(partial: 'message', locals: { message: message })
  end
end
