class ApplicationController < ActionController::Base
  before_action :load_sections
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
    def record_not_found(exception)
      case exception.model
      when 'User'
        message = 'O usuário que você está procurando não pôde ser encontrado.'
      when 'Section'
        message = 'A seção que você está procurando não pôde ser encontrada.'
      when 'Topic'
        message = 'O tópico que você está procurando não pôde ser encontrado.'
      when 'Post'
        message = 'O post que você está procurando não pôde ser encontrado.'
      end

      render 'errors/404', locals: { message: message }
    end

    def sort_topics(topics)
      topics.sort_by do |topic|
        if topic.posts.empty?
          -(topic.created_at.to_f)
        else
          -(topic.posts.last.created_at.to_f)
        end
      end
    end

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
