class MusicsController < ApplicationController
  def index
    if params[:genre_id] && params[:category_id]
      genre = params[:genre_id].to_i
      category = params[:category_id].to_i
      musics = Music.where(category_id: category).where(genre_id: genre).order('created_at DESC').limit(50)
    elsif params[:genre_id]
      genre = params[:genre_id].to_i
      musics = Music.where(genre_id: genre).order('created_at DESC').limit(50)
    elsif params[:category_id]
      category = params[:category_id].to_i
      musics = Music.where(category_id: category).order('created_at DESC').limit(50)
    else
      musics = Music.order('created_at DESC').limit(50)
    end
    render json: musics, methods: :music_url
  end

  def create
    music = Music.new(music_params)
    if music.save
      render json: music, methods: :music_url
    else
      render json: music.errors
    end
  end

  def show
    @music = Music.find(params[:id])
    @user_title = @music.titles.find_by(user_id: params[:user_id])
    render json: @music.as_json( :include => [:titles => { :include => :user}]).merge(user_title: @user_title)

  end

  private

  def music_params
    params_key = [:category_id, :genre_id, :music]
    params.require(:music).permit(params_key).merge(user_id: params[:user_id])
  end
end
