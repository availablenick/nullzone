class UsuariosController < ApplicationController  
  def index
    @usuarios = Usuario.all
  end

  def show
    @usuario = Usuario.find(params[:id])
  end

  def new
    @usuario = Usuario.new
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      redirect_to usuarios_path
    else
      render 'new'
    end
  end

  def update
    @usuario = Usuario.find(params[:id])
    if usuario_params[:avatar]
      @usuario.avatar.attach(usuario_params[:avatar])
    else
      @usuario.avatar.purge if @usuario.avatar.attached?
    end

    if @usuario.update(usuario_params)
      redirect_to usuario_path(@usuario)
    else
      render 'edit'
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.avatar.purge if @usuario.avatar.attached?
    @usuario.destroy

    redirect_to usuarios_path
  end

  private
    def usuario_params
      params.require(:usuario).permit(:login, :password, :assinatura, :avatar)
    end
end
