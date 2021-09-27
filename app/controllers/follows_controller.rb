class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_by_user_id_params, only: [:index]
  before_action :find_user_by_id_params, only: [:followings_list, :followers_list]

  def index
    render json: @user.count_follows.merge(isFollowing: current_user.following?(@user))
  end
  
  def create
    follow = current_user.new_follow(params[:user_id])
    if follow.save
      render json: follow
    else
      render status: 400, json: follow.errors.full_messages
    end
  end
  
  def destroy
    follow = current_user.find_follow(params[:id])
    if follow.destroy
      render json: follow
    else
      render status: 400, json: follow.errors.full_messages
    end
  end
  
  def followings_list
    render json: @user.followings_list
  end

  def followers_list
    render json: @user.followers_list
  end
  
  private
  
  def find_user_by_user_id_params
    @user = User.find(params[:user_id])
  end
  def find_user_by_id_params
    @user = User.find(params[:id])
  end
end