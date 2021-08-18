class TitlesController < ApplicationController
  before_action :find_title_by_id, only: [:show, :destroy]
  def create
    title = Title.new(title_params)
    if title.save
      render json: title
    else
      render json: title.errors
    end
  end

  def show
    render json: @title.as_json(include: [comments: { include: :user }])
  end
  
  def destroy
    if @title.destroy
      render json: @title
    else
      render json: @title.errors
    end
  end

  private
  
  def title_params
    params_key = [:title, :color]
    params.require(:title).permit(params_key).merge(user_id: params[:user_id], music_id: params[:music_id])
  end

  def find_title_by_id
    @title = Title.find(params[:id])
  end
end
