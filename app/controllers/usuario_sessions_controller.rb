class UsuarioSessionsController < ApplicationController
  def new
    @usuario_session = UsuarioSession.new
  end

  def create
    @usuario_session = UsuarioSession.new(usuario_session_params.to_h)
    if @usuario_session.save
      flash[:success] = "Bem-vindo!"
      redirect_to main_path
    else
      render :new
    end
  end

  def destroy
    current_usuario_session.destroy
    flash[:success] = "Tchau!"
    redirect_to main_path
  end

  private
    def usuario_session_params
      params.require(:usuario_session).permit(:login, :password, :remember_me)
    end
end
