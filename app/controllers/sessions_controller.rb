class SessionsController < ApplicationController
  def create
    @current_user = User.find_by(login: session_params[:login])
    if @current_user && @current_user.password == session_params[:password]
      if @current_user.ban && (@current_user.ban.permanent? || @current_user.ban.expires_at > Time.now)
        @ban = @current_user.ban
        @current_user = nil

        render 'new'
      else
        if @current_user.ban
          @current_user.ban.destroy
        end

        session[:user_id] = @current_user.id
        redirect_to root_url
      end
    else
      @current_user = nil
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
