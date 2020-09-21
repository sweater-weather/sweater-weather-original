class RoadTripForecast
  attr_reader :temperature, :description

  def initialize(params)
    @temperature = params[:temperature]
    @description = params[:description]
  end
end
