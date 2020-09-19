class Location
  attr_reader :city,
              :state,
              :country,
              :country_name

  def initialize(location_params)
    @city = location_params[:city]
    @state = location_params[:state]
    @country = location_params[:country]
    @country_name = country_name
  end

  def country_name
    ISO3166::Country.new(@country).data['unofficial_names'][0]
  end
end
