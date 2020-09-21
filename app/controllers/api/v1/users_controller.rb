class Api::V1::UsersController < ApplicationController
  def create
    if params[:password].empty? || params[:password_confirmation].empty? || params[:email].empty?
      render json: { 'error': 'Fields cannot be blank' }, status: 400
    elsif User.exists?(email: params[:email])
      render json: { 'error': 'Email has already been taken' }, status: 400
    elsif params[:password] != params[:password_confirmation]
      render json: { 'error': 'Passwords do not match' }, status: 400
    elsif params[:password] == params[:password_confirmation]
      render json: UserSerializer.new(User.create(user_params)), status: 201
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
