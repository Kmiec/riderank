class RidesController < ApplicationController
  def index
    @rides = Ride.all
  end

  def new
    @ride = Ride.new(ride_params)
  end

  def create
    @ride = Ride.create(ride_params)
    if @ride.valid?
      redirect_to rides_path, notice: 'Good news! Ride aproved!'
    else
      render :new, alert: @ride.errors.to_a
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end

  def stats
    @rides = Ride.group_by_day(:rode_at)
  end
  
  private
  def ride_params
    params.fetch(:ride,{}).permit(:from,:to,:rode_at,:price,:provider_id)
  end
end
