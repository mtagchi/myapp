class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.comments.create(comment_params)
    redirect_back fallback_location: root_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to event_path(params[:event_id])
    end
  end

  private

  def comment_params
    params.permit(:text, :event_id)
  end
end
