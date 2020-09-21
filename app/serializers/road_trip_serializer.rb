class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  set_type :road_trip_forecast
  set_id 'nil?'
  attributes :origin, :destination, :travel_time, :travel_time_formatted, :arrival_forecast
end
