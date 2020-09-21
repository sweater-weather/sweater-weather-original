require 'faraday'
require 'json'
require 'fast_jsonapi'
require 'countries'
MAPQUEST_API_KEY = 'R8CltpLrEDpABIMOSGzsVhl3vweJjgJz'
MAPQUEST_SECRET_KEY = 'EdM0JP2uKsOrLKLN'
WEATHER_API_KEY = 'be267378c346bf9b43e1b8e77fda0adb'

class ForecastFacade
  def initialize(location)
    @location = location
    @city = location.split(',')[0]
    @state = location.split(',')[1]
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

  # private

  def offset
    weather_service[:timezone_offset]
  end

  def weekly_forecast
    weather_service[:daily][1..7].map do |forecast|
      data = {
        date_time: forecast[:dt] + offset,
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
    weather_service[:hourly][0..7].map do |forecast|
      data = {
        icon: forecast[:weather][0][:icon],
        temperature: forecast[:temp],
        date_time: forecast[:dt] + offset
      }
      HourlyForecast.new(data)
    end
  end

  def current_forecast
    data = {
      icon: weather_service[:current][:weather][0][:icon],
      description: weather_service[:current][:weather][0][:main],
      current_weather: weather_service[:current][:temp],
      high: weather_service[:daily][0][:temp][:max],
      low: weather_service[:daily][0][:temp][:min],
      date_time: weather_service[:current][:dt] + offset,
      feels_like: weather_service[:current][:feels_like],
      humidity: weather_service[:current][:humidity],
      visibility: weather_service[:current][:visibility],
      uv_index: weather_service[:current][:uvi],
      sunrise: weather_service[:current][:sunrise],
      sunset: weather_service[:current][:sunset]
    }
    CurrentForecast.new(data)
  end

  def weather_service
    WeatherService.new.get_forecast(latitude, longitute)
  end

  def longitute
    location_service[:latLng][:lng]
  end

  def latitude
    location_service[:latLng][:lat]
  end

  def location_service
    LocationService.new.data(@location)[:results][0][:locations][0]
  end

  def location
    params = {
      city: location_service[:adminArea5].presence || @city,
      state: location_service[:adminArea3].presence || @state,
      country: location_service[:adminArea1],
      id: location_service[:linkId]
    }
    Location.new(params)
  end
end

class Location
  attr_reader :city,
              :state,
              :country,
              :id

  def initialize(location_params)
    @id = location_params[:id]
    @city = location_params[:city]
    @state = location_params[:state]
    @country = location_params[:country]
  end

  def country_name
    ISO3166::Country.new(@country).data['unofficial_names'][0]
  end
end

class CurrentForecast
  attr_reader :description,
              :current_weather,
              :high,
              :low,
              :date_time,
              :feels_like,
              :humidity,
              :visibility,
              :uv_index,
              :sunrise,
              :sunset

  def initialize(current_forecast_params)
    @icon = current_forecast_params[:icon]
    @description = current_forecast_params[:description]
    @current_weather = current_forecast_params[:current_weather]
    @high = current_forecast_params[:high]
    @low = current_forecast_params[:low]
    @date_time = current_forecast_params[:date_time]
    @feels_like = current_forecast_params[:feels_like]
    @humidity = current_forecast_params[:humidity]
    @visibility = current_forecast_params[:visibility]
    @uv_index = current_forecast_params[:uv_index]
    @sunrise = current_forecast_params[:sunrise]
    @sunset = current_forecast_params[:sunset]
  end

  def icon
    "http://openweathermap.org/img/wn/#{@icon}@2x.png"
  end

  def date_time_formatted
    Time.at(@date_time).strftime("%H:%M %p, %B %d")
  end
end

class HourlyForecast
  attr_reader :date_time,
              :temperature

  def initialize(hourly_forecast_params)
    @date_time = hourly_forecast_params[:date_time]
    @icon = hourly_forecast_params[:icon]
    @temperature = hourly_forecast_params[:temperature]
  end

  def icon
    "http://openweathermap.org/img/wn/#{@icon}@2x.png"
  end

  def time
    Time.at(@date_time).strftime('%l %p')
  end
end

class DailyForecast
  attr_reader :date_time,
              :icon,
              :description,
              :snow_percipitation,
              :rain_percipitation,
              :high,
              :low

  def initialize(weekly_forecast_params)
    @date_time = weekly_forecast_params[:date_time]
    @icon = weekly_forecast_params[:icon]
    @description = weekly_forecast_params[:description]
    @snow_percipitation = weekly_forecast_params[:snow_percipitation]
    @rain_percipitation = weekly_forecast_params[:rain_percipitation]
    @high = weekly_forecast_params[:high]
    @low = weekly_forecast_params[:low]
  end

  def weekday
    Time.at(@date_time).strftime('%A')
  end
end

class Forecast
  attr_reader :location,
              :current_forecast,
              :hourly_forecast,
              :weekly_forecast

  def initialize(forecast_params)
    @location = forecast_params[:location]
    @current_forecast = forecast_params[:current_forecast]
    @hourly_forecast = forecast_params[:hourly_forecast]
    @weekly_forecast = forecast_params[:weekly_forecast]
  end
end

class WeatherService
  def get_forecast(lat, lon)
    response = conn.get '/data/2.5/onecall' do |req|
      req.params[:lat] = lat
      req.params[:lon] = lon
      req.params[:exclude] = 'minutely'
    end
    to_json(response)
  end

  private

  def conn
    Faraday.new 'https://api.openweathermap.org' do |f|
      f.params['units'] = 'imperial'
      f.params['appid'] = WEATHER_API_KEY
    end
  end

  def to_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

class LocationService
  def data(location)
    response = conn.get '/geocoding/v1/address' do |req|
      req.params[:location] = location
    end
    to_json(response)
  end

  private
  def conn
    Faraday.new 'http://open.mapquestapi.com' do |f|
      f.params[:key] = MAPQUEST_API_KEY
    end
  end

  def to_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

class LocationSerializer
  include FastJsonapi::ObjectSerializer
  set_type :location
  set_id 'nil?'
  attributes :city, :state, :country, :country_name
end

class CurrentForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_type :forecast
  set_id 'nil?'
  attributes :description, :current_weather, :high, :low, :date_time, :feels_like, :humidity, :visibility, :uv_index, :sunrise, :sunset
end

class DailyForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_type :forecast
  set_id 'nil?'
  attributes :date_time, :icon, :description, :snow_percipitation, :rain_percipitation, :high, :low
end

class HourlyForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_type :forecast
  set_id 'nil?'
  attributes :date_time, :temperature
end

class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_type :forecast
  set_id 'nil?'
  attributes :location, :current_forecast, :weekly_forecast, :hourly_forecast
end

location = LocationService.new
weather = WeatherService.new
ff = ForecastFacade.new('Thornton,CO')
# location_json = LocationSerializer.new(ff.location)
json = ForecastSerializer.new(ff.weather)
require 'pry'; binding.pry
