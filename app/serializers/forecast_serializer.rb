class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_type :forecast
  set_id 'nil?'
  attributes :location, :current_forecast, :weekly_forecast, :hourly_forecast
end
