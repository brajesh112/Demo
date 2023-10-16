module BxBlockCoach
	class CoachesController < ApplicationController
		before_action :authenticate_request

		def index
			@coaches = Coach.all
			render json: BxBlockCoach::CoachSerializer.new(@coaches, meta: {message: "Index Action"}).serializable_hash, status: :ok if @coaches
		end

		def show
			@coach = @current_account.coach
			render json: BxBlockCoach::CoachSerializer.new(@coach, meta: {message: "Show Action"}).serializable_hash, status: :ok if @coach
		end

		def create
			if @current_account.role.eql?("coach")
				@coach = @current_account.build_coach(coach_params)
				if @coach.save
					render json: BxBlockCoach::CoachSerializer.new(@coach, meta: {message: 'Profile Created'}).serializable_hash, status: :created 
				else
					render json:  {errors: @coach.errors.full_messages }, status: :unprocessable_entity
				end
			else
				render plain: "Please Select Correct Role"
			end
		end

		def update
			if @current_account.coach.update(coach_params)
				render json: BxBlockCoach::CoachSerializer.new(@current_account.coach, meta: {message: "Profile Updated"}).serializable_hash, status: :ok
			else
				render json: {errors: @current_account.coach.errors.full_messages}, status: :unprocessable_entity
			end
		end

		private
		
			def coach_params
				params.permit(:name, :practicing_from, :professional_statement)
			end
	end
end