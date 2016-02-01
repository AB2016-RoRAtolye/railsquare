class VenuesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      redirect_to @venue, notice: 'Venue created successfully!'
    else
      render :new, alert: @venue.errors
    end
  end

  def show
    @venue = Venue.find params[:id]

    redirect_to 'venues/new' unless @venue.persisted?
  end

  private
  def venue_params
    params.require(:venue).permit(:name, :address, :category_id)
  end
end
