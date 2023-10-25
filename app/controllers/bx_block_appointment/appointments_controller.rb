module BxBlockAppointment 
	class AppointmentsController < ApplicationController 
		before_action :authenticate_request

		def index
			appointments = @current_account.role.eql?("patient") ?Appointment.where(patient_id: @current_account.id) : @current_account.appointments
			render json: BxBlockAppointment::AppointmentSerializer.new(appointments, meta: {message: "Index action"}).serializable_hash, status: :ok if appointments
		end

		def show
			appointment = Appointment.find_by(id: params[:id])
			render json: BxBlockAppointment::AppointmentSerializer.new(appointment, meta: {message: "Show action"}).serializable_hash, status: :ok if appointment
		end

		def create
			account = AccountBlock::Account.find_by(id: params[:account_id])
			already = Appointment.where(slot: params[:slot_id], date: params[:date])
			if account && !already.present?
				appointment = account.appointments.new(appointment_params)
				appointment.patient_id = @current_account.id 
				appointment.healthcareable_type = account.role
				if appointment.save
					render json: BxBlockAppointment::AppointmentSerializer.new(appointment, meta: {message: "Appointment confirmed"}).serializable_hash, status: :created
				else
					render json: {errors: appointment.errors.full_messages}
				end	
			else
				render json: {error: "Slot already present"}
			end
		end

		def update
			appointment = Appointment.find_by(id: params[:id])
			if appointment
				if appointment.update(appointment_params)
					render json: BxBlockAppointment::AppointmentSerializer.new(appointment, meta: {message: "appointment updated"}).serializable_hash, status: :ok
				else
					render json: {errors: appointment.errors.full_messages}
				end
			else
				render json: {error: "Select correct appointment"}
			end
		end

		def destroy
			appointment = Appointment.find_by(id: params[:id])
			if appointment
				render json: BxBlockAppointment::AppointmentSerializer.new(appointment, meta: {message: "appointment canceled"}).serializable_hash, status: :ok
			else
				render json: {error: "something went wrong"}
			end
		end


		def account
			if params[:query]
				specialization = BxBlockSpecialization::Specialization.find_by(specialization_name: params[:query])
				accounts = specialization.accounts.where(role: "doctor")
			else
				accounts = AccountBlock::Account.where(role: "doctor")
			end
				render json: AccountBlock::AccountSerializer.new(accounts, meta: {message: "Index Action"}).serializable_hash, status: :ok if accounts
		end

		def available_slot
			account = AccountBlock::Account.find_by(id: params[:account_id])
			booked_slots = BxBlockAppointment::Slot.joins(:appointments).where("appointments.date" =>params[:date],"appointments.account_id" => account.id)

			if account.doctor.present?
				slots = BxBlockAppointment::Slot.select{|slot| slot.slot_time.to_time >  account.doctor.start_time.to_time && slot.slot_time.to_time <  account.doctor.end_time.to_time} 
				available_slots = slots.excluding(booked_slots)
			end
			render json: available_slots
		end

		def appointment_params
			params.permit(:slot_id, :date, :status)
		end
	end
end