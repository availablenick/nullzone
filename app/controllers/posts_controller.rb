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
    post_position = find_post_position(@post)
    @topic = @post.topic
    @post.destroy
    
    # Post next to the deleted one
    post_number = post_position + 2
    current_page = (post_number.to_f / 10).ceil
    previous_posts_count = @post.topic.posts.count + 2
    if previous_posts_count > current_page * 10
      next_post = @post.topic.posts.order(:created_at).limit(post_position + (current_page * 10 - post_number + 1)).last()
    else
      next_post = nil
    end

    page_to_go = ((@topic.posts.count.to_f + 1) / 10).ceil
    if @topic.posts.last
      anchor = @topic.posts.last.id
    else
      anchor = 'op-post'
    end

    respond_to do |format|
      path = topic_path(@topic, anchor: anchor, page: page_to_go)

      format.html { redirect_to path }
      format.js   { render 'destroy', locals: { next_post: next_post, post_number: post_number }}
    end
  end

  private
    def post_params
      params.require(:post).permit(:message)
    end
end
