class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment_by_id, only: [:destroy]
  before_action :is_owner, only: [:destroy]
  def index
    @title = Title.find(params[:title_id])
    @music = Music.find(@title.music_id)
    @user_title = @music.titles.find_by(user_id: current_user.id)
    if @user_title || @music.user_id == current_user.id
      comments = Comment.where(title_id: @title.id).joins(:user).select('comments.*', 'users.nickname',
                                                                        'users.icon_color').as_json
      render json: comments                                                                  
    else
      @music.errors.add(:music, 'has not titled')
      render status: 400, json: @music
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
