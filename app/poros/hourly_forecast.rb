class HourlyForecast
  include Formattable

  attr_reader :icon,
              :date_time,
              :temperature,
              :date_time_formatted

  def initialize(hourly_forecast_params)
    @temperature = hourly_forecast_params[:temperature]
    @date_time = hourly_forecast_params[:date_time]
    @date_time_formatted = format_time(@date_time, '%l %p')
    @icon = icon_link(hourly_forecast_params[:icon])
  end
end
