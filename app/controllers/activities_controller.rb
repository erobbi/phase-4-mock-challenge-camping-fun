class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index #show all campers
        activities = Activity.all
        render json: activities
    end

    def destroy
        activity = find_activity   
        activity.destroy
        head :no_content     
    end

    private
    def find_activity
        Activity.find(params[:id])
    end

    def render_not_found_response(exception)
        render json: { error: "Activity not found" }, status: :not_found
    end


end
