class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.nil?
      render json: { 'error': 'Email does not exists' }, status: 400
    elsif user != nil && user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: { 'error': 'Credentials are Bad' }, status: 400
    end
  end
end
