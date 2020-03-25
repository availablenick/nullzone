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

    if params[:section] && params[:section] != 'all'
      section = Section.find_by(name: params[:section])
      @topics = @topics.where(section_id: section.id)
    end

    if @topics.any?
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
  end
end
