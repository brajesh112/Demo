module BxBlockCoach
	class CoachSessionsController < ApplicationController
		before_action :authenticate_request

		def index
			sessions = @current_account.coach_sessions
		end

		def show
		end

		def create

		end

		def update
		end

		def destroy
		end

	end
end