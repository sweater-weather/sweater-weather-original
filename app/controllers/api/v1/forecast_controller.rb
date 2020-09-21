class Api::V1::ForecastController < ApplicationController
  def show
    if params[:location].nil? || params[:location].empty?
      render json: { 'errors': 'No location specified' }, status: 400
    else
      render json: ForecastSerializer.new(weather)
    end
  end

  private

  def weather
    ForecastFacade.new(params[:location]).weather
  end
end
