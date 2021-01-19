require 'securerandom'

class Api::V1::UsersController < ApplicationController
  def create
    user = new_user

    if user.save
      output = UsersSerializer.new(user)
      render json: output, :status => 201
    else
      output = Hash.new
      output[:error] = user.errors.full_messages[0]
      render json: output, :status => 400
    end
  end

  def new_user
    loop do
      @api_key = SecureRandom.base64
      break if User.where(api_key: @api_key) == []
    end
    User.new(user_params.merge({api_key: @api_key}))
  end

  private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end
