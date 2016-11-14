class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.all
  end

  def new
    @microposts = Micropost.new
  end

  def show
    @microposts = Micropost.find(params[:id])
  end
end
