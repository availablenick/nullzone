class SearchController < ApplicationController
  def index
    @topics = nil
    if params[:query] && params[:query] != ''
      keys = params[:query].split(' ')
      keys.each do |k|
        if @topics == nil
          @topics = Topico.where("titulo LIKE (?)", "%#{k}%")
        else
          @topics = @topics.or(Topico.where("titulo Like (?)", "%#{k}%"))
        end
      end
    end
  end
end
