class MainController < ApplicationController
  def index
    @topicos = Topico.all
    @posts = Post.all
  end
end
