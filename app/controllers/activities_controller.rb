class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        activities = Activity.all
        render json: activities
    end

    def destroy
        activity = Activity.find(params[:id])
        activity.destroy
        render head: :no_content
    end

    private

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response
        render json: { error: "Activity not found" }, status: :not_found
    end
    
    def camper_params
        params.permit(:name, :age)
    end
end
