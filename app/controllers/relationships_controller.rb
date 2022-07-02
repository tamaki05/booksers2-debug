class RelationshipsController < ApplicationController
 before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
  private
    def set_user
      @user = User.find(params[:id])
    end
end