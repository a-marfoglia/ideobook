class MicropostViewerController < ApplicationController
  before_action :authenticate_user!

  def show
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless @micropost && @micropost.has_attachment?
    redirect_to @micropost.attachment.url unless @micropost.attachment.file.extension == "docx"
  end
end
