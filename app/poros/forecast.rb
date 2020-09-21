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
