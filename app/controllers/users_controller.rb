# frozen_string_literal: true

# This class handles user sessions
class UsersController < ApplicationController
  def new
    # Create an "empty" user object.  The attributes will be provided by the
    # human user form via the new user form and the object will be saved by the
    # create method here
    @user = User.new
  end

  def create
    # Instantiate a user object based on what is returned from the browser via params hash
    # Below is an example of some Rails security.  Rather than having Rails assign the username
    # etc. attributes directly:
    #   1. use the .require method to identify that it is the user resource we want
    #   2. .permit  method to specifically retrieve the attributes listed

    @user = User.new(whitelist_user_params)

    if @user.save

      # For convenience, perform a log-in for the newly signed up user
      session[:current_user_id] = @user.id

      # Generate a confirmation message for the user.
      flash[:success] = "Welcome #{@user.username}.  You have successfully signed up."

      redirect_to root_path

    else

      # Error trapping
      # Re-render the "new" user page.
      # Because the save returned false, the error trapping on the "new" page
      # will display the errors
      render 'new', status: :unprocessable_entity

    end
  end

  private

  def whitelist_user_params
    params.require(:user).permit(:username, :password)
  end
end
