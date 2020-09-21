class Api::V1::ClimbingRoutesController < ApplicationController
  def index
    render json: ClimbingRoutesSerializer.new(climbing_routes(params[:location]))
  end

  private

  def climbing_routes(location)
    ClimbingRoutesFacade.new(location).climbing_routes
  end
end
