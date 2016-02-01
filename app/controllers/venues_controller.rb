class VenuesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      redirect_to @venue, notice: 'Venue created successfully'
    else
      render 'new', alert: @venue.errors
    end
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def offer
    latitude = request.location.latitude
    longitude = request.location.longitude
    #Venue.near([latitude, longitude], 1000, units: :km)
    @venues = Venue.near([39.998, 32.8799], 10, units: :km)
  end

  def search
    @venues = Venue.search(params[:q])
  end

  private
    def venue_params
      params.require(:venue).permit(:name, :address, :category_id)
    end
end
