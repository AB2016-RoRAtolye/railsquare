class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: [:show, :follow, :unfollow]

  def show
  	@likes = @user.likes
  	@check_ins = @user.check_ins
  	@followers = @user.followers
  	@followings = @user.following
	end

	def follow

		if current_user != @user && !current_user.following_ids.include?(@user.id)
			@user.follow(current_user)
			redirect_to @user, notice: "You are now following #{@user.name}"
		else
			redirect_to @user, alert: "You can't follow"
		end
	end

	def unfollow
		@user.unfollow(current_user)

		redirect_to @user, notice: "You are now not following #{@user.name}"
	end

	private

	def set_user
		@user = User.find(params[:id])
	end
end
