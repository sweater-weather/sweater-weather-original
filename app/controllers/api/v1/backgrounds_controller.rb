class Api::V1::BackgroundsController < ApplicationController
  def show
    if params[:location].nil? || params[:location].empty?
      render json: { 'errors': 'No location specified' }, status: 400
    else
      render json: ImageSerializer.new(image(params[:location])).serializable_hash
    end
  end

  private

  def image(params)
    ImageFacade.new(params).image
  end
end
