class RoadTrip
  attr_reader :origin, :destination, :arrival_forecast, :travel_time, :travel_time_formatted

  def initialize(road_trip_params)
    @origin = road_trip_params[:origin]
    @destination = road_trip_params[:destination]
    @arrival_forecast = road_trip_params[:arrival_forecast]
    @travel_time = road_trip_params[:travel_time]
    @travel_time_formatted = road_trip_params[:travel_time_formatted]
  end
end
