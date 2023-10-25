module BxBlockSession
	class PatientCoachSessionsController < ApplicationController
		before_action :authenticate_request

		def index 
			patient_sessions = @current_account.patient_coach_sessions
			render json: BxBlockSession::PatientCoachSessionSerializer.new(
			patient_sessions, meta: {message: "All registered sessions"}).serializable_hash, status: :ok
		end

		def show
			patient_session = BxBlockSession::PatientCoachSession.find_by(id: params[:id])
			render json: BxBlockSession::PatientCoachSessionSerializer.new(patient_session, meta: {message: "Show action"}).serializable_hash, status: :ok
		end

		def create
			patient_session = BxBlockSession::PatientCoachSession.new(session_params)
			patient_session.patient = @current_account
			patient_session.save 
			render json: BxBlockSession::PatientCoachSessionSerializer.new(patient_session, meta: {message: "registered for session"}).serializable_hash, status: :created
		end

		# def update
		# 	patient_session = BxBlockSession::PatientCoachSession.find_by(id: params[:id])
		# 	patient_session.update(session_params)
		# 	render json: BxBlockSession::PatientCoachSessionSerializer.new(patient_session, meta: {message: "updated session"}).serializable_hash, status: :ok
		# end

		# def destroy
		# end

		def available_sessions
			coach_session = BxBlockSession::CoachSession.find_by(id: params[:coach_session_id])
			booked_session = BxBlockSession::Session.joins(:patient_coach_sessions).where("patient_coach_sessions.date" => params[:date], "patient_coach_sessions.account_id" => params[:coach_id])
			sessions = BxBlockSession::Session.select{|session| session.session_time.to_time >= coach_session.start_time.to_time && session.session_time.to_time <= coach_session.end_time.to_time}
			if coach_session.type.eql?("BxBlockSession::PublicSession")
				empty_session = []
				booked_session.group(:id).count.each{|key, value| empty_session <<  BxBlockSession::Session.find(key) if value < 30}
				available_session = sessions.excluding(booked_session).including(empty_session)
			else
				available_session = sessions.excluding(booked_session)
			end
			render json: BxBlockSession::SessionSerializer.new(available_session, meta: {message: "Select slot"}).serializable_hash, status: :ok if available_session
		end

		def show_coach
			accounts = AccountBlock::Account.where(role: "coach")
			render json: AccountBlock::AccountSerializer.new(accounts, meta: {message: "select coach for session"}).serializable_hash, status: :ok
		end

		def coach_session_id
			account = AccountBlock::Account.find_by(id: params[:coach_id])
			sessions = account.coach_sessions
			render json: BxBlockSession::CoachSessionSerializer.new(sessions, meta: {message: "Select session type"}) if sessions
		end


		private
			def session_params
				params.permit(:coach_session_id, :date, :account_id, :session_id, :payment_status, :patient_id) 
			end
	end
end