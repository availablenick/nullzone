class DenunciationsController < ApplicationController
  def index
    @denuncias = Denunciation.all
  end

  def create
    @denunciation = Denunciation.new(denunciador: denuncia_params[:denunciador],
                                      denunciado: denuncia_params[:denunciado],
                                      post_id: params[:post_id])

    @denunciation.save!
    topico = Topico.find(params[:topico_id])

    redirect_to topico_path(topico)
  end

  def destroy

  end

  private
    def denuncia_params
      params.require(:denuncia).permit(:denunciador, :denunciado)
    end
end
