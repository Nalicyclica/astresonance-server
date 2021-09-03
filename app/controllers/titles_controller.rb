class TitlesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_title_by_id, only: [:show, :destroy]
  before_action :is_owner, only: [:destroy]
  before_action :is_owned_music, only: [:create]
  def create
    if @title.save
      render json: @title
    else
      render status: 400, json: @title.errors
    end
  end

  def show
    @music = Music.find(@title.music_id)
    owner = User.find(@title.user_id)
    @user_title = @music.titles.find_by(user_id: current_user.id)
    if @user_title || @music.user_id == current_user.id
      render json: @title.as_json.merge(nickname: owner.nickname, icon_color: owner.icon_color)
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

  def is_owned_music
    @title = Title.new(title_params)
    if @title.music.user_id == current_user.id
      @title.errors.add(:music, "posted by you can't be titled")
      render status: 400, json: @title.errors
    end
  end
end
