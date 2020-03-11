class SearchController < ApplicationController
  def index
    @topics = []
    keys = params[:query].split(' ')
    keys.each do |key|
      if @topics.any?
        if params[:ws] == 'all-words'
          @topics =
            @topics.where(title: key)
            .or(Topic.where("title LIKE (?)", "#{key} %"))
            .or(Topic.where("title LIKE (?)", "% #{key} %"))
            .or(Topic.where("title LIKE (?)", "% #{key}"))
        else
          @topics =
            @topics.or(Topic.where(title: key))
            .or(Topic.where("title LIKE (?)", "#{key} %"))
            .or(Topic.where("title LIKE (?)", "% #{key} %"))
            .or(Topic.where("title LIKE (?)", "% #{key}"))
        end
      else
        @topics =
          Topic.where(title: key)
          .or(Topic.where("title LIKE (?)", "#{key} %"))
          .or(Topic.where("title LIKE (?)", "% #{key} %"))
          .or(Topic.where("title LIKE (?)", "% #{key}"))
      end
    end

    if params[:section] != 'all'
      section = Section.find_by(name: params[:section])
      @topics = @topics.where(section_id: section.id)
    end
  end
end
