class Api::V1::ForecastController < ApplicationController
  def show
    render json: ForecastSerializer.new(weather)
  end

  private

  def weather
    ForecastFacade.new(params[:location]).weather
  end
end
