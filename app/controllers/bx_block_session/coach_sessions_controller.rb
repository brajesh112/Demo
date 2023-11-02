module BxBlockSession
	class CoachSessionsController < ApplicationController
		before_action :authenticate_request
		before_action :only_coach
		before_action :find_coach_session, only: [:show, :update, :destroy]

		def index
			sessions = @current_account.coach_sessions
			render json: BxBlockSession::CoachSessionSerializer.new(sessions, meta: { message: "Index Action" }).serializable_hash, status: :ok if sessions
		end

		def show
			render json: BxBlockSession::CoachSessionSerializer.new(@session, meta: { message: "Show Action" }).serializable_hash, status: :ok 
		end

		def create
			case params[:type]
				when 'personal'
					session = BxBlockSession::PrivateSession.new(coach_session_params)
				when 'public'
					session = BxBlockSession::PublicSession.new(coach_session_params)
			end
			session.account = @current_account
			session.save	
			render json: BxBlockSession::CoachSessionSerializer.new(session, meta: { message: "Coach session created" }).serializable_hash, status: :created 
		end

		def update
			@session.update(coach_session_params)
			render json: BxBlockSession::CoachSessionSerializer.new(@session, meta: {message: "Coach session updated"})
		end

		def destroy
			@session.destroy
			render json: BxBlockSession::CoachSessionSerializer.new(@session, meta: {message: "Coach session destroyed"})
		end

		private
			def coach_session_params
				params.permit(:notes, :start_time, :end_time, :entery_fee, :fees, :status)
			end

			def only_coach
				unless @current_account.role.eql?("coach")
					render json: {errors: "Your are not autharized for this action"}, status: :unauthorized
				end
			end

			def find_coach_session
				@session = BxBlockSession::CoachSession.find_by(id: params[:id])
				return render json: {error: "Coach session Not found"}, status: :not_found unless @session.present?
			end
	end
end