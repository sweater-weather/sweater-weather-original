class RoadTripForecast
  def initialize(road_trip_forecast_params)
    @temperature = road_trip_forecast_params[:temp]
    @description = road_trip_forecast_params[:weather][0][:description]
  end
end
