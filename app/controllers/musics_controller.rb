class MusicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_music_by_id, only: [:update, :show, :destroy]
  before_action :is_owner, only: [:update, :destroy]
  def index
    render json: music_genre_search()
  end
  
  def create
    music = Music.new(music_params)
    if music.save
      render json: music
    else
      render status: 400, json: music.errors
    end
  end
  
  def update
    if @music.update(info_params)
      render json: @music
    else
      render status: 400, json: @music.errors
    end
  end
  
  def show
    render json: music_show_data()
  end
  
  def destroy
    if @music.destroy
      render json: @music
    else
      render status: 400, json: @music.errors
    end
  end
  
  private
  
  def music_params
    params_key = [:category_id, :genre_id, :music]
    params.permit(params_key).merge(user_id: current_user.id)
  end
  
  def info_params
    params_key = [:category_id, :genre_id]
    params.require(:music).permit(params_key)
  end
  
  def find_music_by_id
    @music = Music.find(params[:id])
  end
  
  def is_owner
    unless current_user.id == @music.user_id
      @music.errors.add(:music, ' is Not owned')
      render status: 400, json: @music.errors
    end
  end
  
  def music_genre_search
    if params[:genre_id] && params[:category_id]
      genre = params[:genre_id].to_i
      category = params[:category_id].to_i
      return Music.where(category_id: category).where(genre_id: genre).order('created_at DESC').limit(50)
    elsif params[:genre_id]
      genre = params[:genre_id].to_i
      return Music.where(genre_id: genre).order('created_at DESC').limit(50)
    elsif params[:category_id]
      category = params[:category_id].to_i
      return Music.where(category_id: category).order('created_at DESC').limit(50)
    else
      return Music.order('created_at DESC').limit(50)
    end
  end

  def music_show_data
    if user_signed_in?
      user_title = @music.titles.find_by(user_id: current_user.id)
      if user_title || current_user.id == @music.user_id
        owner = User.find(@music.user_id)
        titles = Title.where(music_id: @music.id).eager_load(:user).select('titles.*', 'users.nickname', 'users.icon_color')
        return @music.as_json.merge(nickname: owner.nickname, icon_color: owner.icon_color, titles: titles,
          user_title: user_title, music_url: @music.music_url)
      end
    end
    return @music.as_json.merge(music_url: @music.music_url)
  end
end
