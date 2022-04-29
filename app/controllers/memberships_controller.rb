class MembershipsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable
    def create
        if Membership.find_by(gym_id: params[:gym_id], client_id: params[:client_id])
            render json: {error: "One membership bruh"}, status: :not_acceptable
        else
            membership = Membership.create!(params.permit(:gym_id, :client_id, :charge))
            render json: membership, status: :created
        end
    end

        private

        def render_unprocessable invalid
            render json: { errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
        end
end
