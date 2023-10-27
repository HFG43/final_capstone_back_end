class Api::UsersController < ApplicationController
  def show
    unless user = User.find_by(username: params[:username])
      render json: { exist: false }
    else
      render json: { exist: true }
    end
  end

  def create
      json_request = JSON.parse(request.body.read)

      name = json_request['name']
      username = json_request['username']

      new_user = User.new(name:, username:)

      if new_user.save
        render json: new_user, status: :created
      else
        render json: { errors: new_user.errors.full_messages }, status: :unprocessable_entity
      end
  end
end