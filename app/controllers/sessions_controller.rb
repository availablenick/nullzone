class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new
    @session.login = session_params[:login]
    @session.password = session_params[:password]

    current_user = User.find_by(login: session_params[:login])
    if @session.valid?
      if current_user.ban
        current_user.ban.destroy
      end

      session[:user_id] = current_user.id
    else
      if @session.errors.details[:login][0][:error] == :banned
        @ban = current_user.ban
      end
    end

    respond_to do |format|
      format.js
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
