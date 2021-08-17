class TitlesController < ApplicationController
  def create
    title = Title.new(title_params)
    if title.save
      render json: title
    else
      render json: title.errors
    end
  end

  private

  def title_params
    params_key = [:title, :color]
    params.require(:title).permit(params_key).merge(user_id: params[:user_id], music_id: params[:music_id])
  end
end