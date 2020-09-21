class CurrentForecast
  include Formattable

  attr_reader :icon,
              :description,
              :current_weather,
              :high,
              :low,
              :date_time,
              :feels_like,
              :humidity,
              :visibility,
              :uv_index,
              :sunrise,
              :sunset,
              :date_time_formatted,
              :sunrise_time,
              :sunset_time

  def initialize(current_forecast_params)
    @description = current_forecast_params[:description]
    @current_weather = current_forecast_params[:current_weather]
    @icon = icon_link(current_forecast_params[:icon])
    @high = current_forecast_params[:high]
    @low = current_forecast_params[:low]
    @date_time = current_forecast_params[:date_time]
    @date_time_formatted = format_time(@date_time, '%l:%M %p, %B %d')
    @feels_like = current_forecast_params[:feels_like]
    @humidity = current_forecast_params[:humidity]
    @visibility = current_forecast_params[:visibility]
    @uv_index = current_forecast_params[:uv_index]
    @sunrise = current_forecast_params[:sunrise]
    @sunset = current_forecast_params[:sunset]
    @sunrise_time = format_time(@sunrise, '%l:%M %p')
    @sunset_time = format_time(@sunset, '%l:%M %p')
  end
end
