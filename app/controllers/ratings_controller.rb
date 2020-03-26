class RatingsController < ApplicationController
  def create
    respond_to do |format|
      @post = Post.find(params[:post_id])
      if @post.topic.locked?
        format.js { render js: '' }
      else
        if (!@post.ratings.find_by(user_id: current_user.id))
          @rating = @post.ratings.build(rating_params)
          current_user.ratings << @rating

          if @rating.save
            path = topic_path(@post.topic, anchor: @post.id, page: find_post_page(@post))
            format.html { redirect_to path }
            format.js
          else
            format.html { render 'topics/show' }
          end
        end
      end
    end
  end

  def update
    respond_to do |format|
      @rating = Rating.find_by(id: params[:id])
      if @rating.post.topic.locked?
        format.js { render js: '' }
      else
        if @rating.update(rating_params)
          path = topic_path(@rating.post.topic, anchor: @rating.post.id, page: find_post_page(@rating.post))
          format.html { redirect_to path}
          format.js
        else
          format.html { render 'topics/show' }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      @rating = Rating.find_by(id: params[:id])
      if @rating.post.topic.locked?
        format.js { render js: '' }
      else
        post = @rating.post
        @rating.destroy

        path = topic_path(post.topic, anchor: post.id, page: find_post_page(post))
        format.html { redirect_to path }
        format.js
      end
    end
  end

  private
    def rating_params
      params.require(:rating).permit(:value)
    end
end
