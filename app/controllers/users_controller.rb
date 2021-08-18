class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    titles = Title.where(user_id: user.id).as_json(include: :music)
    comments = Comment.where(user_id: user.id).as_json(include: :title)
    musics = Music.where(user_id: user.id).joins(:titles).select('musics.*',
                                                                 'titles.title').where(titles: { user_id: params[:user_id] })
    render json: user.as_json.merge(titles: titles, comments: comments, musics: musics)
  end
end
