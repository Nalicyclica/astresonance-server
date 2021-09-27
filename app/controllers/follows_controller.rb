class FollowsController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    render json: user.count_follows.merge(isFollowing: current_user.following?(user))
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
end
