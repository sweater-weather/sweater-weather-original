class Api::V1::BackgroundsController < ApplicationController
  def show
    render json: ImageSerializer.new(image(params[:location])).serializable_hash
  end

  private

  def image(params)
    ImageFacade.new(params).image
  end
end
