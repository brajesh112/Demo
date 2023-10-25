module BxBlockSession
	class CoachSessionsController < ApplicationController
		before_action :authenticate_request

		def index
			sessions = @current_account.coach_sessions
			render json: BxBlockSession::CoachSessionSerializer.new(sessions, meta: { message: "Index Action" }).serializable_hash, status: :ok if sessions && @current_account.role.eql?("coach")
		end

		def show
			session = BxBlockSession::CoachSession.find_by(id: params[:id])
			render json: BxBlockSession::CoachSessionSerializer.new(session, meta: { message: "Show Action" }).serializable_hash, status: :ok if session && @current_account.role.eql?("coach")
		end

		def create
			case params[:type]
				when 'personal'
					session = BxBlockSession::PrivateSession.new(coach_session_params)
				when 'public'
					session = BxBlockSession::PublicSession.new(coach_session_params)
			end
			session.account = @current_account
			if @current_account.role.eql?('coach')
				session.save	
				render json: BxBlockSession::CoachSessionSerializer.new(session, meta: { message: "Coach session created" }).serializable_hash, status: :created 
			else
				render json: {errors: "Your are not autharized for this action"}
			end
		end

		def update
			session = BxBlockSession::CoachSession.find_by(id: params[:id])
			session.update(coach_session_params) if @current_account.role.eql?('coach')
			render json: BxBlockSession::CoachSessionSerializer.new(session, meta: {message: "Coach session updated"})
		end

		def destroy
			session = BxBlockSession::CoachSession.find_by(id: params[:id])
			session.destroy if @current_account.role.eql?('coach')
			render json: BxBlockSession::CoachSessionSerializer.new(session, meta: {message: "Coach session destroyed"})
		end

		private
			def coach_session_params
				params.permit(:notes, :start_time, :end_time, :entery_fee, :fees, :status)
			end
	end
end