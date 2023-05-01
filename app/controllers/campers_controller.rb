class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperShowSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, include: :activities, status: :created
    end

    private

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end
    
    def camper_params
        params.permit(:name, :age)
    end
end
