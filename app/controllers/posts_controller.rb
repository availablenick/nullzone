class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      path = topic_path(@post.topic, anchor: @post.id, page: find_post_page(@post))

      format.html { redirect_to path }
      format.js
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    current_user.posts << @post

    respond_to do |format|
      if @post.save
        page_to_go = ((@topic.posts.count.to_f + 1) / 10).ceil
        current_page = params[:post][:current_page]
        path = topic_path(@topic, anchor: @post.id, page: page_to_go)

        format.html { redirect_to path }
        format.js
      else
        format.html { render 'topics/show' }
      end
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
    
    respond_to do |format|
      page_to_go = ((@topic.posts.count.to_f + 1) / 10).ceil
      path = topic_path(@topic, anchor: @topic.posts.last.id, page: page_to_go)

      format.html { redirect_to path }
      format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:message)
    end
end
