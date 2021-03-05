class SessionsController < ApplicationController
	def new
	end

  def index
    counter = 1
    numusers = 500
    while counter < numusers do 
      username = "EdgYM3m3l0Rd_#{counter}"
      new_user = User.create!(username: username, password: "password", email: "#{username}@email.com")
      counter += 1
    end

    counter = 1
    while counter < numusers do 
      user_count = 0
      while user_count < 3 do
        connected_user = User.find(counter)
        Profile.create!(user: connected_user, name: "Rick_#{counter}_#{user_count}", age: 21, occupation: "job", location: "place", bio: "hi")
        user_count += 1
      end
      counter += 1
    end

  end


  def create
    user_params = params.require(:session).permit(:username, :password)
    user = User.find_by(username: user_params[:username].downcase)
    if user && user.authenticate(user_params[:password])
      log_in user
      if (url = session[:prelogin_url]) == nil
        redirect_to controller: 'home', action: 'index'
      else
        session.delete(:prelogin_url)
        redirect_to url
      end
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unauthorized
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
