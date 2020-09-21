class Api::V1::RoadTripController < ApplicationController
  def create
    if User.exists?(api_key: params[:api_key])
      render json: RoadTripSerializer.new(road_trip(params[:origin], params[:destination]))
    else
      render json: { 'error': 'Api Key does not exist' }, status: 400
    end
  end

  private

  def road_trip(origin, destination)
    RoadTripFacade.new(origin, destination).road_trip
  end
end
