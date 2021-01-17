require 'securerandom'

class Api::V1::UsersController < ApplicationController
  def create
    # user creation
    loop do
      @api_key = SecureRandom.base64
      break if User.where(api_key: @api_key) == []
    end
    user = User.create(user_params.merge({api_key: @api_key}))

    output = UsersSerializer.new(user)
    render json: output
  end

  private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end
