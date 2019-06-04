class UsuarioSessionsController < ApplicationController
  def new
    session[:previous_page] = request.referrer
    @usuario_session = UsuarioSession.new
  end

  def create
    @usuario_session = UsuarioSession.new(usuario_session_params.to_h)
    if @usuario_session.save
      redirect_to session.delete(:previous_page)
    else
      render :new
    end
  end

  def destroy
    current_usuario_session.destroy
    
    redirect_to request.referrer
  end

  private
    def usuario_session_params
      params.require(:usuario_session).permit(:login, :password)
    end
end
