class ClimbingRoute
  attr_reader :location, :forecast, :routes

  def initialize(params)
    @location = params[:location]
    @forecast = params[:forecast]
    @routes = params[:routes]
  end
end
