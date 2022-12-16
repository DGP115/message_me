# frozen_string_literal: true

# This class handles processing of commands from the browser regarding the chatroom
class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @message = Message.new
    @messages = Message.custom_fetch
  end
end
