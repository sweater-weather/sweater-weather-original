class ClimbingRoutesFacade
  attr_reader :location, :longitude, :latitude
  def initialize(location)
    @location = location
    @longitude = coordinates[:lng]
    @latitude = coordinates[:lat]
  end

  def climbing_routes
    data = {
      location: @location,
      forecast: forecast,
      routes: routes
    }
    ClimbingRoute.new(data)
  end

  private

  def location_service
    LocationService.new
  end

  def coordinates
    location_service.data(@location)[:results][0][:locations][0][:latLng]
  end

  def weather_service
    WeatherService.new.get_forecast(@latitude, @longitude)
  end

  def forecast
    forecast = {
      summary: weather_service[:current][:weather][0][:description],
      temperature: weather_service[:current][:temp]
    }
  end

  def climbing_routes_service
    ClimbingRoutesService.new.routes(@latitude, @longitude)
  end

  def routes
    # routes = []
    climbing_routes_service[:routes].map do |route_data|
      latlng = "#{route_data[:latitude]},#{route_data[:longitude]}"
      distance = location_service.road_trip(@location, latlng)[:route][:legs][0][:distance]
      r = Route.new(route_data)
      r.set_distance_to_route(distance)
      # routes << r
      r
    end
    # routes
  end
end
