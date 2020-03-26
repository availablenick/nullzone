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
    @topic = Topic.find(params[:id])
    if !(current_user && current_user.login == 'ADM')
      if @topic.locked? || !current_user || current_user != @topic.user
        redirect_to @topic
      end
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
    locked_changed = topic_params[:locked] && @topic.locked? != topic_params[:locked]
    pinned_changed = topic_params[:pinned] && @topic.pinned? != topic_params[:pinned]

    if (locked_changed || pinned_changed) && !(current_user && current_user.login == 'ADM')
      redirect_to section_topics_path(@topic.section)
    end

    if current_user && (current_user.login == 'ADM' || current_user == @topic.user && !@topic.locked?)
      if @topic.update(topic_params)
        if locked_changed || pinned_changed
          redirect_to section_topics_path(@topic.section)
        else
          redirect_to @topic
        end
      else
        render 'edit'
      end
    else
      redirect_to @topic
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    if current_user && (current_user.login == 'ADM' || current_user == @topic.user && !@topic.locked?)
      @section = @topic.section
      @topic.destroy

      redirect_to section_topics_path(@section)
    else
      redirect_to @topic
    end
  end

  private
    def topic_params
      params.require(:topic).permit(:title, :message, :locked, :pinned)
    end
end
