class RoadTripFacade
  attr_reader :origin, :destination

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @longitude = coordinates[:lng]
    @latitude = coordinates[:lat]
  end

  def road_trip
    data = {
      origin: @origin,
      destination: @destination,
      arrival_forecast: arrival_forecast,
      travel_time: travel_time,
      travel_time_formatted: travel_time_formatted
    }
    RoadTrip.new(data)
  end

  private

  def weather_service
    WeatherService.new.get_forecast(@latitude, @longitude)
  end

  def location_service
    LocationService.new
  end

  def arrival_forecast
    data = weather_service[:hourly].find do |forecast|
      forecast[:dt] >= DateTime.now.to_i + travel_time
    end
    RoadTripForecast.new(data)
  end

  def travel_time
    location_service.road_trip(@origin, @destination)[:route][:legs][0][:time]
  end

  def travel_time_formatted
    location_service.road_trip(@origin, @destination)[:route][:formattedTime]
  end

  def coordinates
    c = location_service.data(@destination)[:results][0][:locations][0][:latLng]
  end
end
