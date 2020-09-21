class CurrentForecast
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
    @date_time_formatted = formatted_time
    @feels_like = current_forecast_params[:feels_like]
    @humidity = current_forecast_params[:humidity]
    @visibility = current_forecast_params[:visibility]
    @uv_index = current_forecast_params[:uv_index]
    @sunrise = current_forecast_params[:sunrise]
    @sunrise_formatted = sunrise_time
    @sunset = current_forecast_params[:sunset]
    @sunset_formatted = sunset_time
  end

  def icon_link(code)
    "http://openweathermap.org/img/wn/#{code}@2x.png"
  end

  def formatted_time
    Time.at(@date_time).strftime("%l:%M %p, %B %d")
  end

  def sunrise_time
    Time.at(@sunrise).strftime("%l:%M %p")
  end

  def sunset_time
    Time.at(@sunset).strftime("%l:%M %p")
  end
end
