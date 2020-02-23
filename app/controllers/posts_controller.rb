class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    #redirect_to topic_path(@post.topic, anchor: @post.id, page: find_post_page(@post));
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    current_user.posts << @post

    if @post.save
      page_number = ((@topic.posts.count.to_f + 1) / 10).ceil
      redirect_to topic_path(@topic, anchor: @post.id, page: page_number)
    else
      render 'topics/show'
    end
  end

  def update
    @post = Post.find(params[:id])
  
    if @post.update(post_params)
      redirect_to topic_path(@post.topic, anchor: @post.id, page: find_post_page(@post))
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @topic = @post.topic
    @post.destroy
    page_number = ((@topic.posts.count.to_f + 1) / 10).ceil

    redirect_to topic_path(@topic, anchor: @topic.posts.last.id, page: page_number)
  end

  private
    def post_params
      params.require(:post).permit(:message)
    end
end
