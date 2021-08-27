class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    owner = User.select('users.id', 'users.nickname', 'users.icon_color', 'users.introduce').find(params[:id])
    titles = Title.where(user_id: owner.id).as_json
    comments = Comment.where(user_id: owner.id).as_json(include: :title)
    user_titles = Title.where(user_id: current_user.id).select('titles.title', 'titles.color', 'titles.music_id')
    musics = Music.joins("LEFT OUTER JOIN (#{user_titles.to_sql}) user_titles ON musics.id = user_titles.music_id").select('musics.*','user_titles.title', 'user_titles.color').where(user_id: owner.id)
    render json: owner.as_json.merge(titles: titles, comments: comments, musics: musics)
  end
end
