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
    @topico = Topico.new(topico_params)
    if @topico.save
      redirect_to topico_path(@topico)
    else
      render 'new'
    end
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
