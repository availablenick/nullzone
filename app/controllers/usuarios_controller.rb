class UsuariosController < ApplicationController  
  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(usuario_params)
    
    if @usuario.save
      redirect_to main_path
    end
  end

  private
    def usuario_params
      params.require(:usuario).permit(:nome, :senha)
    end
end
