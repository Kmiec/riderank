require 'will_paginate'
#@todo: secure by user?
class RidesController < ApplicationController
  def index
    page = params[:page] || 1
    @rides = Ride.paginate(page: page)
  end

  def new
    @ride = Ride.new(ride_params)
  end

  def create
    @ride = Ride.create(ride_params)
    if @ride.persisted?
      redirect_to rides_path, notice: 'Good news! Ride aproved!'
    else
      flash.now[:alert]= 'This is sad. Ride is not aproved! Fill up required fields!'
      render :new
    end
  end
  #@todo: show only valid, map in view?
  def show
    @ride = Ride.geocoded.where(id:params[:id]).first
    redirect_to rides_path, alert: 'Ride is bad or not exist. Sorry ;('  if @ride.nil?
  end

  def stats
    @rides = Ride.stats_query
  end
  
  private
  def ride_params
    params.fetch(:ride,{}).permit(:from,:to,:rode_date,:price,:provider_id)
  end
end
