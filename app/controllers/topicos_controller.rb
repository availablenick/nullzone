class TopicosController < ApplicationController

  def index
    @topicos = Topico.all
  end

  def show
    @topico = Article.find(params[:id])
  end

  def new
  end

  private
    def topico_params
      params.require(:topico).permit(:titulo, :mensagem)
    end

end
