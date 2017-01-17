class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    #@microposts = Micropost.search(params[:search])
    @microposts = Micropost.search(params[:search],params[:category]).paginate(page: params[:page], per_page: 10)
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
  
  def edit
    @micropost =  Micropost.find(params[:id])
  end
  
  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:notice] =  "Post aggiornato con successo."
      redirect_to @micropost
    else
      render 'edit'
    end
  end
  
  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    redirect_to '/microposts', :notice => "La tua storia è stata rimossa"
  end

  private
    def micropost_params
      params.require(:micropost).permit(:title, :content, :category_id, :attachment)
    end
    
    def correct_user
      redirect_to root_path unless Micropost.find(params[:id]).user == current_user
    end
end
