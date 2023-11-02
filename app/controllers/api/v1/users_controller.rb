class Api::V1::UsersController < ApplicationController
  def show
    user = User.find_by(username: params[:id])
    if user.nil?
      render json: { exist: false }, status: 500
    else
      render json: { exist: true, id: user.id, name: user.name, username: user.username }
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
