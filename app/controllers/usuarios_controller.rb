class UsuariosController < ApplicationController  
  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(usuario_params)
    
    if @usuario.save
      redirect_to main_path
    else
      render 'new'
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    redirect_to main_path
  end

  private
    def usuario_params
      params.require(:usuario).permit(:nome, :senha)
    end
end
