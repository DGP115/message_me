# frozen_string_literal: true

# This is the controller for the articles resource
class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: %i[new create]

  def new; end

  def create
    user = User.find_by(username: params[:session][:username])

    # Not my style but rubocop prefers the "&." operator versus if user && user.authenticate...
    # Recall that the .authenticate method comes with the Bcrypt gem installed to handle
    # password encryption and validation
    if user&.authenticate(params[:session][:password])
      # Record id of successfully logged-in user in session object (physically stored by Rails
      # in a cookie)
      session[:current_user_id] = user.id
      flash[:success] = 'Login was successful.'
      redirect_to root_path
    else
      flash[:warning] = 'Login was not successful.  Please try again.'
      # Normally, The render statement below would be used, along with flash.now,
      # but it caused the javascript that operates semantic ui dropdown menus to not work
      #     render :new, status: :unprocessable_entity
      redirect_to login_path

    end
  end

  def destroy
    session[:current_user_id] = nil
    flash[:info] = 'You are now logged out'
    redirect_to root_path
  end

  private

  def logged_in_redirect
    return unless logged_in?

    flash[:warning] = 'You are already logged in'
    redirect_to root_path
  end
end
