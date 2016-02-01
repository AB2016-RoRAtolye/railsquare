class CheckInsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_venue

  def create
    @check_in = current_user.check_ins.new(check_in_params)

    @check_in.save
    render 'venues/show'
  end

  private

  def check_in_params
    params.require(:check_in).permit(:image).merge!({venue_id: @venue.id})
  end

  def set_venue
    @venue = Venue.find params[:venue_id]
  end
end
