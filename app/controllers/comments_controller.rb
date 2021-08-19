class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment_by_id, only: [:destroy]
  before_action :is_owner, only: [:destroy]
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors
    end
  end

  def destroy
    if @comment.destroy
      render json: @comment
    else
      render json: @comment.errors
    end
  end

  private

  def comment_params
    params_key = [:text]
    params.require(:comment).permit(params_key).merge(user_id: current_user.id, title_id: params[:title_id])
  end

  def find_comment_by_id
    @comment = Comment.find(params[:id])
  end

  def is_owner
    unless current_user.id == @comment.user_id
      @comment.errors.add(:title, ' is Not owned')
      render status: 400, json: @comment.errors
    end
  end
end
