module BxBlockAppointment 
	class AppointmentsController < ApplicationController 
		before_action :authenticate_request

		def index
			@appointments = @current_account.role.eql?("patient") ?Appointment.where(patient_id: @current_account.id) : @current_account.appointments
			render json: BxBlockAppointment::AppointmentSerializer.new(@appointments, meta: {message: "Index action"}).serializable_hash, status: :ok if @appointments
		end

		def show
			@appointment = Appointment.find_by(id: params[:id])
			render json: BxBlockAppointment::AppointmentSerializer.new(@appointment, meta: {message: "Show action"}).serializable_hash, status: :ok if @appointment
		end

		def create
			@account = AccountBlock::Account.find_by(id: params[:account_id])
			if @account
				@appointment = @account.appointments.new(patient_id: @current_account.id, slot_id: params[:slot], date: params[:date], healtcareable_type: @account.role)

				if @appointment.save
					render json: BxBlockAppointment::AppointmentSerializer.new(@appointment, meta: {message: "Appointment confirmed"}).serializable_hash, status: :created
				else
					render json: {errors: @appointment.errors.full_messages}
				end
			else
				render json: {error: "Select correct healthcare"}
			end
		end

		def update
			@appointment = Appointment.find_by(id: params[:id])
			if @appointment
				if @appointment.update(slot_id: params[:slot], date: params[:date])
					render json: BxBlockAppointment::AppointmentSerializer.new(@appointment, meta: {message: "appointment updated"}).serializable_hash, status: :ok
				else
					render json: {errors: @appointment.errors.full_messages}
				end
			else
				render json: {error: "Select correct appointment"}
			end
		end

		def destroy
			@appointment = Appointment.find_by(id: params[:id])
			if @appointment
				if @appointment.destroy
					render json: BxBlockAppointment::AppointmentSerializer.new(@appointment, meta: {message: "appointment canceled"}).serializable_hash, status: :ok
				else
					render json: {errors: @appointment.errors.full_messages}
				end
			else
				render json: {error: "something went wrong"}
			end
		end
	end
end