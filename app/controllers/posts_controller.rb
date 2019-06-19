class PostsController < ApplicationController
  def edit
    @topico = Topico.find(params[:topico_id])
    @post = @topico.posts.find(params[:id])
  end

  def create
    @topico = Topico.find(params[:topico_id])
    @post = Post.new(mensagem: post_params[:post][:mensagem],
                      topico_id: params[:topico_id],
                      usuario_id: current_usuario.id)

    if @post.save
      page = 1 + @topico.posts.count / 10
      redirect_to topico_path(@topico, page: page, anchor: "#{@topico.posts.count}")
    else
      render 'topicos/show'
    end
  end

  def update
    @topico = Topico.find(params[:topico_id])
    @post = @topico.posts.find(params[:id])
    
    if @post.update(post_params)
      redirect_to topico_path(@topico, page: params[:page], anchor: "#{params[:count]}")
    else
      render 'edit'
    end
  end

  def destroy
    @topico = Topico.find(params[:topico_id])
    @post = @topico.posts.find(params[:id])
    @post.destroy

    page = 1 + @topico.posts.count / 10
    redirect_to topico_path(@topico, page: page, anchor: "#{@topico.posts.count}")
  end

  private
    def post_params
      params.require(:post).permit(:mensagem)
    end
end
