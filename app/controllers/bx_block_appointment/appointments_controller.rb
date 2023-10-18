module BxBlockAppointment 
	class AppointmentsController < ApplicationController 
		before_action :authenticate_request

		def show
			case @current_account.role
			when "doctor"
				@appointment = @current_account.doctor.appointments.find_by(id: params[:id])
			when "patient"
				@appointment = @current_account.patient.appointments.find_by(id: params[:id])
			else
				@appointment = nil
			end
		end

		def create
			

		end

		def update
			case @current_account.role
			when "doctor"
				@appointment = @current_account.doctor.appointments.find_by(id: params[:id])
			when "patient"
				@appointment = @current_account.patient.appointments.find_by(id: params[:id])
			else
				@appointment = nil
			end
		end

		def destroy

		end

	end
end