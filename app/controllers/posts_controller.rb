class PostsController < ApplicationController
  def edit
    @topico = Topico.find(params[:topico_id])
    @post = @topico.posts.find(params[:id])
  end

  def create
    @topico = Topico.find(params[:topico_id])
    @post = Post.new(mensagem: post_params[:mensagem],
                      arquivo: post_params[:arquivo],
                      video: post_params[:video],
                      topico_id: params[:topico_id],
                      usuario_id: current_usuario.id)

    @post.arquivo.attach(post_params[:arquivo])

    if @post.save
      page = ((@topico.posts.count + 1).to_f / 10).ceil
      redirect_to topico_path(@topico, page: page, anchor: "#{@post.id}")
    else
      render 'topicos/show'
    end
  end

  def update
    @topico = Topico.find(params[:topico_id])
    @post = @topico.posts.find(params[:id])
    
    if @post.update(post_params)
      redirect_to topico_path(@topico, page: params[:page], anchor: "#{@post.id}")
    else
      render 'edit'
    end
  end

  def destroy
    @topico = Topico.find(params[:topico_id])
    @post = @topico.posts.find(params[:id])
    @post.destroy

    page = ((@topico.posts.count + 1).to_f / 10).ceil
    redirect_to topico_path(@topico, page: page, anchor: "#{@post.id}")
  end

  private
    def post_params
      params.require(:post).permit(:mensagem, :arquivo, :video)
    end
end
