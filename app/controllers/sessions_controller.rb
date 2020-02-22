class SessionsController < ApplicationController
  def create
    @current_user = User.find_by login: session_params[:login]
    if @current_user && @current_user.password == session_params[:password]
      session[:user_id] = @current_user.id
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil

    redirect_to root_url
  end

  private
    def session_params
      params.require(:session).permit(:login, :password)
    end
end
