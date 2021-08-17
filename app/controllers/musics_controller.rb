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
    render json: musics
  end
end
