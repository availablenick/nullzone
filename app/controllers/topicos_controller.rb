class TopicosController < ApplicationController
  def index
    @topicos = Topico.all
  end

  def show
    @topico = Topico.find(params[:id])
  end

  def new
    @topico = Topico.new
  end

  def create
    # params[:usuario_id] = 1 should get from session
    id = params[:topico][:usuario_id]
    @usuario = Usuario.find(id)
    @topico = @usuario.topicos.create(topico_params)

    redirect_to topico_path(@topico)
  end

  def destroy
    @topico = Topico.find(params[:id])
    @topico.destroy

    redirect_to topicos_path
  end

  private
    def topico_params
      params.require(:topico).permit(:titulo, :mensagem, :usuario_id)
    end

end
