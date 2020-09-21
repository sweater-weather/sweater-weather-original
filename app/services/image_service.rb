class ImageService
  def image(query)
    response = conn.get '/search/photos' do |req|
      req.params['query'] = query
    end
    to_json(response)[:results][0]
  end

  private

  def conn
    Faraday.new 'https://api.unsplash.com/' do |f|
      f.headers['Accept-Version'] = 'v1'
      f.params['client_id'] = ENV['UNSPLASH_API_KEY']
    end
  end

  def to_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
