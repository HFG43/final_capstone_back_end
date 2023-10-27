class Api::V1::ExperiencesController < ApplicationController
  # GET /experiences
  def index
    experiences = Experience.all
    render json: experiences
  end
end
