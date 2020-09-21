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
    climbing_routes_service[:routes].map do |route_data|
      Route.new(route_data)
    end
  end
end
