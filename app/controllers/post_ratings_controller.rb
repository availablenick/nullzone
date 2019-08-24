class PostRatingsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @rating = @post.post_ratings.build(rating_params)
    current_usuario.post_ratings << @rating

    if @rating.save
      redirect_to topico_path(@post.topico, page: params[:page], anchor: "#{@post.id}")
    else
      render 'topicos/show'
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @rating = @post.post_ratings.find(params[:id])

    if @rating.update(rating_params)
      redirect_to topico_path(@post.topico, page: params[:page], anchor: "#{@post.id}")
    else
      render 'topicos/show'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @rating = @post.post_ratings.find(params[:id])
    @rating.destroy

    redirect_to topico_path(@post.topico, page: params[:page], anchor: "#{@post.id}")
  end

  private
    def rating_params
      params.require(:post_rating).permit(:value)
    end
end
