class DenunciationsController < ApplicationController
  def index
    @denuncias = Denunciation.all
  end

  def create
    @denuncia = Denunciation.new(denuncia_params)
    @denuncia.save!

    if @denuncia.tipo == 'topico'
      topico = Topico.find(@denuncia.source_id)
      back_anchor = 'op-post'
    else
      post = Post.find(@denuncia.source_id)
      topico = post.topico
      back_anchor = "#{post.id}"
    end

    redirect_to topico_path(topico, anchor: back_anchor)
  end

  def destroy
    @denuncia = Denunciation.find(params[:id])
    @denuncia.destroy

    redirect_to denuncias_path
  end

  private
    def denuncia_params
      params.require(:denuncia).permit(:denunciador, :denunciado, :tipo, :source_id)
    end
end
