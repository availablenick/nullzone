class TopicosController < ApplicationController
  def index
    @topicos = nil
    if params[:query] && params[:query] != ''
      keys = params[:query].split(' ')
      keys.each do |k|
        if @topicos == nil
          @topicos = Topico.where("titulo LIKE (?)", "%#{k}%")
        else
          @topicos = @topicos.or(Topico.where("titulo Like (?)", "%#{k}%"))
        end
      end
    else
      # Sort by more recent time
      @topicos = Topico.all.sort_by do |t|
        if t.posts.empty?
          -(t.created_at.to_f)
        else
          -(t.posts.last.created_at.to_f)
        end
      end
    end
  end

  def show
    @topico = Topico.find(params[:id])
    @posts = @topico.posts.order(:created_at)
  end

  def new
    @topico = Topico.new
  end

  def edit
    @topico = Topico.find(params[:id])
  end

  def create
    @topico = current_usuario.topicos.build(topico_params)

    if @topico.save
      @topico.touch(time: @topico.created_at)
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
      params.require(:topico).permit(:titulo, :mensagem)
    end
end
