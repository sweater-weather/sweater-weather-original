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
      f.params['appid'] = ENV['WEATHER_API_KEY']
    end
  end

  def to_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
