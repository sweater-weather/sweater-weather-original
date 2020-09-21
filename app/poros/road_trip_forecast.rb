class RoadTripForecast
  attr_reader :temperature, :description

  def initialize(params)
    @temperature = params[:temp]
    @description = params[:weather][0][:description]
  end
end
