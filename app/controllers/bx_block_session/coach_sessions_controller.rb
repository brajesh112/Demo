module BxBlockSession
	class CoachSessionsController < ApplicationController
		before_action :authenticate_request

		def index
			sessions = @current_account.role.eql?("patient") ? @current_account.other_coach_sessions : @current_account.coach_sessions
			render json: BxBlockSession::CoachSessionSerializer.new(sessions, meta: { message: "Index Action" }).serializable_hash, status: :ok if sessions
		end

		def show
			session = BxBlockSession::CoachSession.find_by(id: params[:id])
			render json: BxBlockSession::CoachSessionSerializer.new(session, meta: { message: "Show Action" }).serializable_hash, status: :ok 
		end

		def create
			case params[:type]
				when 'personal'
					session = BxBlockSession::PrivateSession.create(session_params)
				when 'public'
					session = BxBlockSession::PublicSession.create(session_params)
			end
			# session.accounts << @current_account
			render json: BxBlockSession::CoachSessionSerializer.new(session, meta: { message: "Personal session created" }).serializable_hash, status: :ok 
		end

		def update

		end

		def destroy

		end

		def available_sessions
			debugger
			date = params[:date]
			sessions = BxBlockSession::PublicSession.select{|session| session.accounts.count < 30 && session.date == date.to_date }
			my_sessions = @current_account.other_coach_sessions.where(date: date.to_date)
			available_sessions = sessions.excluding(my_sessions)
			available_sessions = BxBlockSession::PublicSession.create(session_params) unless available_sessions
			render json: BxBlockSession::CoachSessionSerializer.new(available_sessions, meta: { message: "Available sessions" }).serializable_hash, status: :ok 
		end

		def show_coach
			accounts = AccountBlock::Account.where(role: "coach")
			render json: AccountBlock::AccountSerializer.new(accounts, meta: {message: "select coach for session"}).serializable_hash, status: :ok
		end

		private
			def session_params
				params.permit(:notes, :account_id, :start_time, :end_time, :entry_fee, :fees, :status)
			end
	end
end