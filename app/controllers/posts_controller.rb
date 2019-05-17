class PostsController < ApplicationController
  def create
    @topico = Topico.find(params[:topico_id])
    @post = @topico.posts.create(post_params)

    redirect_to topico_path(@topico)
  end

  def destroy
    @topico = Topico.find(params[:topico_id])
    @post = @topico.posts.find(params[:id])
    @post.destroy

    redirect_to topico_path(@topico)
  end

  private
    def post_params
      params.require(:post).permit(:mensagem, :topico_id, :usuario_id)
    end
end
