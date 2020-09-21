require 'faraday'
require 'json'
require 'fast_jsonapi'
require 'countries'
MAPQUEST_API_KEY = 'R8CltpLrEDpABIMOSGzsVhl3vweJjgJz'
SECRET = 'EdM0JP2uKsOrLKLN'

class ForecastController
  def show
    render json: ForecastSerializer(ForecastFacade(params[:location]))
  end
end

# http://open.mapquestapi.com/geocoding/v1/address?key=KEY&location=Washington,DC

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

class ForecastFacade
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def make_forecast
    data = {
      location: Location.new(weather_params)
    }
  end

  def location_service
    LocationService.new.data(@location)[:results][0][:locations][0]
  end

  def longitute
    location_service[:latLng][:lng]
  end

  def latitude
    location_service[:latLng][:lat]
  end

  def country
    country = location_service[:adminArea1]
    ISO3166::Country.new.data['unofficial_names'][0]
  end

  def city
    location_service[:adminArea5]
  end

  def state
    location_service[:adminArea3]
  end

  def weather_params
    params = ['city', 'state', 'longitute', 'latitude', 'country']
    params = params.reduce({}) do |acc, param|
      acc[param.to_sym] = public_send("#{param}")
      acc
    end
    require 'pry'; binding.pry
  end

  def weather_data(location)
    WeatherService.new.get_forecast(lat(location), lng(location))
  end
end

# https://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&exclude={part}&appid={YOUR API KEY}
WEATHER_API_KEY = 'be267378c346bf9b43e1b8e77fda0adb'
class WeatherService
  def get_forecast(lat, lon)
    response = conn.get '/data/2.5/onecall' do |req|
      req.params[:lat] = lat
      req.params[:lon] = lon
      req.params[:exclude] = 'minutely,hourly'
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

class Forecast
  attr_reader :location

  def initialize(forecast_params)
    @location = forecast_params[:location]
  end
end

class DailyForecast
end

class Location
  attr_reader :city,
              :state,
              :country,
              :longitute,
              :latitude

  def initialize(location_params)
    @city = location_params[:city]
    @state = location_params[:state]
    @country = location_params[:country]
    @longitute = location_params[:longitute]
    @latitude = location_params[:latitude]
  end
end

# x = ForecastFacade.new('Denver,CO').make_forecast
x = LocationService.new
require 'pry'; binding.pry
