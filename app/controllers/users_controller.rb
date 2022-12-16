# frozen_string_literal: true

# This class handles user sessions
class UsersController < ApplicationController
  # before_action is a helper.  It is run first [limited to only statement] as a
  # means of DRYing code
  before_action :set_user, only: %i[show edit update destroy]
  # The below ensures that a user that is not logged in can't access user profiles
  # by entering routes directly in the browser address bar
  before_action :require_user, only: %i[edit update]
  # The below runs after "set_user" (above) so "require_same_user" can use object
  # "@user" knowing it has been instantiated [because it is instantiated
  # in "set_user"]
  before_action :require_same_user, only: %i[edit update destroy]

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

  def edit; end

  def update
    if @user.update(whitelist_user_params)
      flash[:info] = 'Your user info has been updated'
      redirect_to chatroom_path
    else
      flash[:error] = 'The update of your user info failed'
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def whitelist_user_params
    params.require(:user).permit(:username, :password)
  end

  # 1.  Recall that the http GET function passes to the Controller the current user
  #     (from the browser) in the URI given by user/id
  #     Rails passes this argument in the form of the params hash, so we can get the id by
  #     referring to params[:id]
  # 2.  Use an instance variable, which in this case is an object, as Rails makes it
  #     available to the View for us
  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    return unless current_user != @user

    flash[:warning] = 'You can only modify your own profile'
    redirect_to @user
  end
end
