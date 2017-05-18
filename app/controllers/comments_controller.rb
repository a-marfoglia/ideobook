class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

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
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    micropost = @comment.micropost
    redirect_to micropost
  end

  private
    def comment_params
      hash_params = params.require(:comment).permit(:content).merge({
                                         micropost_id: @micropost.id })
    end
    
    def correct_user
      redirect_to root_path unless Comment.find(params[:id]).user == current_user
    end

    def create_notification(comment)
      comment.micropost.comments.select(:user_id).distinct.each do |c|
        Notification.create( user_id: c.user_id,
                             subscribed_user_id: current_user.id,
                             comment_id: comment.id,
                             micropost_id: comment.micropost.id,
                             notice_type: 2
                            ) if comment.micropost.user.id != c.user_id &&
                                 c.user_id != current_user.id

      end
      Notification.create( user_id: comment.micropost.user.id,
                           subscribed_user_id: current_user.id,
                           comment_id: comment.id,
                           micropost_id: comment.micropost.id,
                           notice_type: 2
                          ) if comment.micropost.user != current_user
    end
end
