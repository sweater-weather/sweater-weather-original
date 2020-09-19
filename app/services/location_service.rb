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
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end

  def to_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
