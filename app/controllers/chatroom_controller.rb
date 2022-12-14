# frozen_string_literal: true

# This class handles processing of commands from the browser regarding the chatroom
class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @messages = Message.paginate(page: params[:page], per_page: 12).order('created_at DESC')
  end
end
