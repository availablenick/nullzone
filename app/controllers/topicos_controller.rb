class TopicosController < ApplicationController
  def index
    @topicos = Topico.all.sort_by do |t|
      if t.posts.empty?
        -(t.created_at.to_f)
      else
        -(t.posts.last.created_at.to_f)
      end
    end
  end

  def show
    @topico = Topico.find(params[:id])
  end

  def new
    @topico = Topico.new
  end

  def edit
    @topico = Topico.find(params[:id])
  end

  def create
    fields = params[:topico]
    @topico = Topico.new(titulo: fields[:titulo],
                          mensagem: fields[:mensagem],
                          usuario_id: current_usuario.id)
    if @topico.save
      redirect_to topico_path(@topico)
    else
      render 'new'
    end
  end

  def update
    @topico = Topico.find(params[:id])
    if @topico.update(topico_params)
      redirect_to topico_path(@topico)
    else
      render 'edit'
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
