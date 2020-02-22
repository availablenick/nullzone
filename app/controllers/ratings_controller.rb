class RatingsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @rating = @post.ratings.build(rating_params)
    current_user.ratings << @rating

    respond_to do |format|
      if @rating.save
        path = topic_path(@post.topic, anchor: @post.id, page: find_post_page(@post))
        format.html { redirect_to path }
        format.js
        format.json { render json: @rating, status: :created, location: path }
      else
        format.html { render 'topics/show' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @rating = Rating.find(params[:id]);

    respond_to do |format|
      if @rating.update(rating_params)
        path = topic_path(@rating.post.topic, anchor: @rating.post.id, page: find_post_page(@rating.post))
        format.html { redirect_to path}
        format.js
        format.json { render json: @rating, status: :ok }
      else
        format.html { render 'topics/show' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rating = Rating.find(params[:id])
    post = @rating.post
    @rating.destroy

    respond_to do |format|
      path = topic_path(post.topic, anchor: post.id, page: find_post_page(post))
      format.html { redirect_to path }
      format.js
      format.json { render json: @rating, status: :ok } 
    end
  end

  private
    def rating_params
      params.require(:rating).permit(:value)
    end
end
