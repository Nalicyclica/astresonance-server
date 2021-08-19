class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    owner = User.find(params[:id])
    titles = Title.where(user_id: owner.id).as_json(include: :music)
    comments = Comment.where(user_id: owner.id).as_json(include: :title)
    musics = Music.where(user_id: owner.id).joins(:titles).select('musics.*',
                                                                  'titles.title').where(titles: { user_id: current_user.id })
    render json: owner.as_json.merge(titles: titles, comments: comments, musics: musics)
  end
end
