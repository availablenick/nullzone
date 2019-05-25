class ApplicationController < ActionController::Base
  private
    def current_usuario_session
      return @current_usuario_session if defined?(@current_usuario_session)
      @current_usuario_session = UsuarioSession.find
    end

    def current_usuario
      return @current_usuario if defined?(@current_usuario)
      @current_usuario = current_usuario_session && current_usuario_session.usuario
    end
    
  helper_method :current_usuario_session, :current_usuario
end
