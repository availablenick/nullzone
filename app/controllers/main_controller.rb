class MainController < ApplicationController
  def index
    @usuarios = Usuario.all
  end
end
