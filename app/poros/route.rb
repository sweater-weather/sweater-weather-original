class Route
  attr_reader :name, :type, :rating, :location, :distance_to_route

  def initialize(params)
    @name = params[:name]
    @type = params[:type]
    @rating = params[:rating]
    @location = params[:location]
    @distance_to_route= params[:distance_to_route]
  end
end
