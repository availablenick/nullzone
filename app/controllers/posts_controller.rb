class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])

    remote = true
    if (find_post_position(@post) + 2) % 10 == 1
      last_post = Post.where(topic_id: @post.topic.id).order(created_at: :desc).limit(1)[0];
      if @post.id == last_post.id
        remote = false
      end
    end

    respond_to do |format|
      path = topic_path(@post.topic, anchor: @post.id, page: find_post_page(@post))

      format.html { redirect_to path }
      format.js { render 'show', locals: { remote: remote } }
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    if !(current_user && current_user.login == 'ADM')
      if @post.topic.locked? || !current_user || current_user != @post.user
        redirect_to @post.topic
      end
    end
  end

  def create
    respond_to do |format|
      @topic = Topic.find(params[:topic_id])
      
      if @topic.locked
        format.js { render js: '' }
      else
        @post = @topic.posts.build(post_params)
        @post.parsed_message = replace_tags(post_params[:message])
        current_user.posts << @post
        current_page = params[:post][:current_page].to_i
        page_to_go = nil
        if @post.save
          page_to_go = ((@topic.posts.count.to_f + 1) / 10).ceil
          path = topic_path(@topic, anchor: @post.id, page: page_to_go)
        else
          path = topic_path(@topic, anchor: 'leave-a-post', page: page_to_go)
        end

        format.html { redirect_to path }

        if page_to_go && page_to_go != current_page
          format.js { render js: 'window.location.href = "' + path + '"' }
        else
          format.js
        end
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if current_user && (current_user.login == 'ADM' || current_user == @post.user && !@post.topic.locked?)
      if @post.update(post_params)
        @post.update_attribute(:parsed_message, replace_tags(post_params[:message]))
        redirect_to topic_path(@post.topic, anchor: @post.id, page: find_post_page(@post))
      else
        render 'edit'
      end
    else
      redirect_to @post.topic
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user && (current_user.login == 'ADM' || current_user == @post.user && !@post.topic.locked?)
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
    end

    respond_to do |format|      
      if current_user && (current_user.login == 'ADM' || current_user == @post.user && !@post.topic.locked?)
        path = topic_path(@topic, anchor: anchor, page: page_to_go)

        format.html { redirect_to path }
        format.js { render 'destroy', locals: { next_post: next_post, post_number: post_number }}
      else
        format.js { render js: 'window.location.href = "' + topic_path(@post.topic) + '"' }
      end
    end
  end

  private
    def post_params
      params.require(:post).permit(:message)
    end
end
