class SectionsController < ApplicationController
  def index
    @sections = Section.all
  end

  def new
  end

  def show
    @section = Section.find(params[:id])
  end

  def edit
  end
end
