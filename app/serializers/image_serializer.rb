class ImageSerializer
  include FastJsonapi::ObjectSerializer
  set_type :image
  set_id 'nil?'
  attributes :location, :image_url, :credit
end
