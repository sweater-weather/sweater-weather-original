class ClimbingRoutesSerializer
  include FastJsonapi::ObjectSerializer
  set_id 'nil?'
  set_type 'climbing route'
  attributes :location, :forecast, :routes
end
