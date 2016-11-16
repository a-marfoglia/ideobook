class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @microposts = Micropost.paginate(page: params[:page], per_page: 10)
  end

  def show
    @micropost = Micropost.find(params[:id])
    @micropost.increment_views
    @comment = Comment.new
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to @micropost
    else
      render 'new'
    end
  end

  private
    def micropost_params
      params.require(:micropost).permit(:title, :content, :category_id, :attachment)
    end
end
