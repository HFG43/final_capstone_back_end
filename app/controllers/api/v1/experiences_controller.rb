class Api::V1::ExperiencesController < ApplicationController
  # GET /experiences
  def index
    experiences = Experience.all
    render json: experiences
  end

  # GET /experiences/:id
  def show
    experience = Experience.find(params[:id])
    render json: experience
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Record not found' }, status: 500
  end
end
