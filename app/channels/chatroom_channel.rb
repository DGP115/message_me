# frozen_string_literal: true

# This class handles definition of the ActionCable Sockets channel for the chatroom
class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chatroom_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
