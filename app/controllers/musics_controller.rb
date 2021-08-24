class MusicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_music_by_id, only: [:update, :show, :destroy]
  before_action :is_owner, only: [:update, :destroy]
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
    if user_signed_in?
      @user_title = @music.titles.find_by(user_id: current_user.id)
      if @user_title || current_user.id == @music.user_id
        # titles = Title.find_by_sql(["SELECT titles.* users.nickname users.icon_color FROM titles WHERE titles.music_id=? INNER JOIN users ON titles.user_id=users.id", @music.id])
        titles = Title.where(music_id: @music.id).joins(:user).select('titles.*', 'users.nickname', 'users.icon_color')
        return render json: @music.as_json.merge(titles: titles, user_title: @user_title, music_url: @music.music_url)
        # render json: @music.as_json(include: [titles: { include: :user }]).merge(user_title: @user_title, music: @music.music_url)
      end
    end
    render json: @music.as_json.merge(music_url: @music.music_url)
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
end
