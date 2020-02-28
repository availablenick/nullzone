class ApplicationController < ActionController::Base
  before_action :load_sections

  private
    def load_sections
      @section_list = Section.all
    end

    def current_user
      @current_user ||= session[:user_id] && User.find(session[:user_id])
    end

    def find_post_position(post)
      post_position = post.topic.posts.order(:created_at).map { |post| post.id } .index(post.id)
    end

    def find_post_page(post)
      post_position = find_post_position(post) + 2
      return (post_position.to_f / 10).ceil
    end

  helper_method :current_user, :find_post_position, :find_post_page
end
