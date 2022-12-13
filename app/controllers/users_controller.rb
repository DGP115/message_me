# frozen_string_literal: true

# This class handles user sessions
class UsersController < ApplicationController
  def new
    # Create an "empty" user object.  The attributes will be provided by the
    # human user form via the new user form and the object will be saved by the
    # create method here
    @user = User.new
  end

  def create; end
end
