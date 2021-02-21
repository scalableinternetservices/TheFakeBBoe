class SessionsController < ApplicationController
	def new
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
