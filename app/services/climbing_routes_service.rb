class ClimbingRoutesService
  def routes(lat, lon)
    response = conn.get '/data/get-routes-for-lat-lon' do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
    end
    to_json(response)
  end

  private

  def conn
    Faraday.new 'https://www.mountainproject.com' do |f|
      f.params['key'] = ENV['MOUNTAIN_API_KEY']
      f.params['maxDistance'] = 10
    end
  end

  def to_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
