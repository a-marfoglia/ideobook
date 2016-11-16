class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to @micropost
    else
      render 'microposts/show'
    end
  end

  private
    def comment_params
      hash_params = params.require(:comment).permit(:content).merge({
                                          micropost_id: @micropost.id })
    end
end
