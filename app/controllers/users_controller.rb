class UsersController < ApplicationController
	before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@likes = @user.likes
  	@check_ins = @user.check_ins
  	@followers = @user.followers
  	@followings = @user.followings
  end
end
