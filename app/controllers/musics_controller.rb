class MusicsController < ApplicationController
  before_action :find_music_by_id, only: [:update, :show, :destroy]
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

  def update
    if @music.update(info_params)
      render json: @music
    else
      render json: @music.errors
    end
  end

  def show
    # 後でuserはnameやicon_color情報のみ絞るようにSQLで書き直すこと
    @user_title = @music.titles.find_by(user_id: params[:user_id])
    if @user_title
      render json: @music.as_json(include: [titles: { include: :user }]).merge(user_title: @user_title, music: @music.music_url)
    else
      render json: @music, methods: music_url
    end
  end

  def destroy
    if @music.destroy
      render json: @music
    else
      render json: @music.errors
    end
  end

  private

  def music_params
    params_key = [:category_id, :genre_id, :music]
    params.require(:music).permit(params_key).merge(user_id: params[:user_id])
  end

  def info_params
    params_key = [:category_id, :genre_id]
    params.require(:music).permit(params_key)
  end

  def find_music_by_id
    @music = Music.find(params[:id])
  end
end
