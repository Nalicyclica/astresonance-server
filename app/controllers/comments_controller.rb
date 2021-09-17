class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment_by_id, only: [:destroy]
  before_action :is_owner, only: [:destroy]
  def index
    title = Title.eager_load([:user, :music]).select('titles.*','users.nickname','users.icon_color', 'musics.user_id AS music_user_id').find(params[:title_id])
    user_title = Title.find_by(music_id: title.music_id, user_id: current_user.id)
    if user_title || title.music_user_id == current_user.id
      comments = Comment.where(title_id: title.id).eager_load(:user).select('comments.*', 'users.nickname',
                                                                        'users.icon_color').as_json
      render json: comments                                                                  
    else
      errors = comments.errors.add(:music, 'has not titled')
      render status: 400, json: errors
    end
  end

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
