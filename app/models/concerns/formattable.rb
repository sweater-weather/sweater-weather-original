module Formattable
  extend ActiveSupport::Concern
  
  def icon_link(code)
    "http://openweathermap.org/img/wn/#{code}@2x.png"
  end
end
