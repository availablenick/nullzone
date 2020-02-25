class ComplaintsController < ApplicationController
  def index
    if current_user && current_user.login == 'ADM'
      @complaints = Complaint.all
    else
      redirect_to root_url
    end
  end

  def create
    if complaint_params[:which_type] == 'topic'
      @topic = Topic.find(params[:topic_id])
      @complaint = @topic.complaints.build(complaint_params)
      topic = @topic
      anchor = 'op-post'
      page_number = 1
    else
      @post = Post.find(params[:post_id])
      @complaint = @post.complaints.build(complaint_params)
      topic = @post.topic
      anchor = @post.id
      page_number = find_post_page(@post)
    end

    current_user.complaints << @complaint

    if @complaint.save
      redirect_to topic_path(topic, anchor: anchor, page: page_number)
    else
      render 'topics/show'
    end
  end

  def destroy
    @complaint = Complaint.find(params[:id])
    @complaint.destroy

    redirect_to complaints_path
  end

  private
    def complaint_params
      params.require(:complaint).permit(:which_type, :complainee)
    end
end
