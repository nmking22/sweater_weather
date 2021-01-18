class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user != nil && user.authenticate(params[:password])
      output = UsersSerializer.new(user)
      render json: output
    else
      output = Hash.new
      output[:error] = 'Bad Credentials'
      render json: output, :status => 400
    end
  end

  private

    def sessions_params
      params.permit(:email, :password)
    end
end
