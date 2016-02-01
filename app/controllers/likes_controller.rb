class LikesController < ApplicationController
  def create
  	venue = Venue.find(params[:venue_id])
  	current_user.likes.create(venue_id: venue.id)
  	@total_like = venue.likes.size
  end
end
