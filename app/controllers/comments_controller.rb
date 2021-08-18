class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors
    end
  end

  private

  def comment_params
    params_key = [:text]
    params.require(:comment).permit(params_key).merge(user_id: params[:user_id], title_id: params[:title_id])
  end
end
