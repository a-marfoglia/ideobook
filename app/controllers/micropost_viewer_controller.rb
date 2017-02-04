class MicropostViewerController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless @micropost.has_attachment?
  end
end
