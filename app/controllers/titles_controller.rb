class TitlesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_title_by_id, only: [:show, :destroy]
  before_action :is_owner, only: [:destroy]
  def create
    title = Title.new(title_params)
    if title.save
      render json: title
    else
      render status: 400, json: title.errors
    end
  end

  def show
    @music = Music.find(@title.music_id)
    @user_title = @music.titles.find_by(user_id: current_user.id)
    if @user_title
      comments = Comment.where(title_id: @title.id).joins(:user).select('comments.*', 'users.nickname',
                                                                        'users.icon_color').as_json
      render json: @title.as_json.merge(comments: comments, user_title: @user_title,
                                        music: @music.as_json.merge(music: @music.music_url))
    else
      @music.errors.add(:music, 'has not titled')
      render status: 400, json: @music
    end
  end

  def destroy
    if @title.destroy
      render json: @title
    else
      render status: 400, json: @title.errors
    end
  end

  private

  def title_params
    params_key = [:title, :color]
    params.require(:title).permit(params_key).merge(user_id: current_user.id, music_id: params[:music_id])
  end

  def find_title_by_id
    @title = Title.find(params[:id])
  end

  def is_owner
    unless current_user.id == @title.user_id
      @title.errors.add(:title, ' is Not owned')
      render status: 400, json: @title.errors
    end
  end
end
