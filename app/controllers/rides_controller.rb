#@todo: secure by user?
class RidesController < ApplicationController
  #@todo: index scope only valid?
  def index
    @rides = Ride.all
  end

  def new
    @ride = Ride.new(ride_params)
  end

  def create
    @ride = Ride.create(ride_params)
    if @ride.persisted?
      redirect_to rides_path, notice: 'Good news! Ride aproved!'
    else
      flash[:alert]= 'This is sad. Ride is not aproved!'
      flash[:alert]= @ride.errors.to_a
      render :new
    end
  end
  #@todo: show only valid, map in view?
  def show
    @ride = Ride.find(params[:id])
  end

  def stats
    @rides = Ride.stats_query
  end
  
  private
  def ride_params
    params.fetch(:ride,{}).permit(:from,:to,:rode_date,:price,:provider_id)
  end
end
