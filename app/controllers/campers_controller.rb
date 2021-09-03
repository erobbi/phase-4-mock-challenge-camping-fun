class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response #helps to raise exceptions for bad validations

    wrap_parameters format: []

    def index #show all campers
        campers = Camper.all
        render json: campers

    end

    def show # show only one camper at a time
        camper = find_camper
        render json: camper, status: :ok
    end

    def create #create a new camper
        camper = Camper.create!(camper_params) #! raise an exception
        render json: camper, status: :created
    end

    private
    def find_camper
        Camper.find(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
