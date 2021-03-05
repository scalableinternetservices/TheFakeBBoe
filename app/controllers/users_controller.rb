class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      # Login user after sign-up
      log_in @user
      flash[:success] = "Welcome to the Meme Dating App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
