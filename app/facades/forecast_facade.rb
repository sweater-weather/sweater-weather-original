require 'countries'

class ForecastFacade
  def initialize(location_param)
    @location_param = location_param
    @city = location_param.split(',')[0]
    @state = location_param.split(',')[1]
  end

  def weather
    data = {
      location: location,
      current_forecast: current_forecast,
      hourly_forecast: hourly_forecast,
      weekly_forecast: weekly_forecast
    }
    Forecast.new(data)
  end

  private

  def longitude
    location_service[:latLng][:lng]
  end

  def latitude
    location_service[:latLng][:lat]
  end

  def weekly_forecast
    weather_service[:daily][1..7].map do |forecast|
      data = {
        date_time: forecast[:dt],
        icon: forecast[:weather][0][:icon],
        description: forecast[:weather][0][:main],
        snow_percipitation: forecast[:snow],
        rain_percipitation: forecast[:rain],
        high: forecast[:temp][:min],
        low: forecast[:temp][:max]
      }
      DailyForecast.new(data)
    end
  end

  def hourly_forecast
    weather_service[:hourly][1..8].map do |forecast|
      data = {
        icon: forecast[:weather][0][:icon],
        temperature: forecast[:temp],
        date_time: forecast[:dt]
      }
      HourlyForecast.new(data)
    end
  end

  def current_forecast
    data = {
      icon: weather_service[:current][:weather][0][:icon],
      description: weather_service[:current][:weather][0][:description],
      current_weather: weather_service[:current][:temp],
      high: weather_service[:daily][0][:temp][:max],
      low: weather_service[:daily][0][:temp][:min],
      date_time: weather_service[:current][:dt],
      feels_like: weather_service[:current][:feels_like],
      humidity: weather_service[:current][:humidity],
      visibility: weather_service[:current][:visibility],
      uv_index: weather_service[:current][:uvi],
      sunrise: weather_service[:current][:sunrise],
      sunset: weather_service[:current][:sunset]
    }
    CurrentForecast.new(data)
  end

  def location
    params = {
      city: location_service[:adminArea5].presence || @city,
      state: location_service[:adminArea3].presence || @state,
      country: location_service[:adminArea1],
    }
    Location.new(params)
  end

  def weather_service
    WeatherService.new.get_forecast(latitude, longitude)
  end

  def location_service
    LocationService.new.data(@location_param)[:results][0][:locations][0]
  end
end
