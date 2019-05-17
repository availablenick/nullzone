class UsuariosController < ApplicationController  
  def new
    @usuario = Usuario.new
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def create
    @usuario = Usuario.new(usuario_params)
    
    if @usuario.save
      redirect_to main_path
    else
      render 'new'
    end
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update(usuario_params)
      redirect_to main_path
    else
      render 'edit'
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
