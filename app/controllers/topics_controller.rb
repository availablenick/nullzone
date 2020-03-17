class TopicsController < ApplicationController
  def index
    @section = Section.find(params[:section_id])
    @topics = @section.topics

    # Sort by time (most recent first)
    @pinned_topics = @topics.where(pinned: true)
    @unpinned_topics = @topics.where(pinned: false)

    @pinned_topics = sort_topics(@pinned_topics)
    @unpinned_topics = sort_topics(@unpinned_topics)

    @topics = []
    @pinned_topics.each do |topic|
      @topics.push(topic)
    end

    @unpinned_topics.each do |topic|
      @topics.push(topic)
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.order(:created_at)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    if current_user
      @section = Section.find(params[:section_id])
      @topic = Topic.new
    else
      redirect_to login_path
    end
  end

  def edit
    if current_user
      @topic = Topic.find(params[:id])
    else
      redirect_to_login_path
    end
  end

  def create
    @section = Section.find(params[:section_id])
    @topic = @section.topics.build(topic_params)
    current_user.topics << @topic

    if @topic.save
      redirect_to @topic
    else
      render 'new'
    end
  end

  def update
    @topic = Topic.find(params[:id])
    pinned_changed = @topic.pinned? != topic_params[:pinned]

    if pinned_changed && !(current_user && current_user.login == 'ADM')
      redirect_to section_topics_path(@topic.section)
    end
    
    if @topic.update(topic_params)
      if pinned_changed
        redirect_to section_topics_path(@topic.section)
      else
        redirect_to @topic
      end
    else
      render 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @section = @topic.section
    @topic.destroy

    redirect_to section_topics_path(@section)
  end

  private
    def topic_params
      params.require(:topic).permit(:title, :message, :pinned)
    end
end
