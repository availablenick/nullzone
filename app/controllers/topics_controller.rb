class TopicsController < ApplicationController
  def index
    @section = Section.find(params[:section_id])
    @topics = @section.topics

    # Sort by time (most recent first)
    @topics = Topic.all.sort_by do |topic|
      if topic.posts.empty?
        -(topic.created_at.to_f)
      else
        -(topic.posts.last.created_at.to_f)
      end
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.order(:created_at)
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
    @topic = @section.topics.find(params[:id])
    
    if @topic.update(topic_params)
      redirect_to @topic
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
      params.require(:topic).permit(:title, :message)
    end
end
