class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      create_notification(@comment)
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
    
    def create_notification(comment)
      comment.micropost.comments.select(:user_id).distinct.each do |c|
        Notification.create( user_id: c.user_id,
                             subscribed_user_id: current_user.id,
                             comment_id: comment.id,
                             micropost_id: comment.micropost.id,
                             notice_type: 2
                            )
      #TODO: Possessore del micropost
      end
    end
end
