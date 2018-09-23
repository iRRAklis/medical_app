class Api::V1::DiseasesController < Api::V1::BaseController
  def index
  	@diseases = Disease.all
  	render json: @diseases.as_json(only: [:id, :name]), status: :ok
  end
end