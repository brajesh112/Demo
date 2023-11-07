module BxBlockAppointment 
	class AppointmentsController < ApplicationController 
		before_action :authenticate_request
		before_action :find_appointment, only: [:show, :update, :destroy]

		def index
			appointments = @current_account.role.eql?("patient") ?Appointment.where(patient_id: @current_account.id) : @current_account.appointments
			render json: BxBlockAppointment::AppointmentSerializer.new(appointments).serializable_hash, status: :ok
		end

		def show
			render json: BxBlockAppointment::AppointmentSerializer.new(@appointment).serializable_hash, status: :ok
		end

		def create
			account = AccountBlock::Account.find_by(id: params[:account_id])
			booked_slots = Appointment.find_by(slot: params[:slot_id], date: params[:date])
			return render json: {error: "slot is already booked"}, status: :unprocessable_entity unless account && !booked_slots
			appointment = account.appointments.new(appointment_params)
			appointment.patient_id = @current_account.id 
			appointment.healthcareable_type = account.role
			return render json: BxBlockAppointment::AppointmentSerializer.new(appointment, meta: {message: "Appointment confirmed"}).serializable_hash, status: :created if appointment.save
			render json: {error: appointment.errors.full_messages}, status: :unprocessable_entity
		end

		def update
			return render json: {errors: @appointment.errors.full_messages}, status: :unprocessable_entity unless @appointment.update(appointment_params)
			render json: BxBlockAppointment::AppointmentSerializer.new(@appointment, meta: {message: "appointment updated"}).serializable_hash, status: :ok
		end

		def destroy
			render json: BxBlockAppointment::AppointmentSerializer.new(@appointment, meta: {message: "appointment canceled"}).serializable_hash, status: :ok
		end


		def account
			accounts = AccountBlock::Account.where(role: "doctor")
			if params[:query]
				specialization = BxBlockSpecialization::Specialization.find_by(specialization_name: params[:query])
				accounts = specialization.accounts.where(role: "doctor")
			end
			render json: AccountBlock::AccountSerializer.new(accounts).serializable_hash, status: :ok
		end

		def available_slot
			account = AccountBlock::Account.find_by(id: params[:account_id], role: "doctor")
			return render json: {error: "Doctor not found"}, status: :not_found unless account
			
			booked_slots = BxBlockAppointment::Slot.joins(:appointments).where("appointments.date" => params[:date],"appointments.account_id" => account.id) 
			slots = BxBlockAppointment::Slot.select{|slot| slot.slot_time.to_time >  account.doctor.start_time.to_time && slot.slot_time.to_time <  account.doctor.end_time.to_time} 
			available_slots = slots.excluding(booked_slots)
			render json: available_slots
		end

		def appointment_params
			params.permit(:slot_id, :date, :status)
		end

		def find_appointment
			@appointment = Appointment.find_by(id: params[:id])
			return render json: {error: "Appointment does not exists"}, status: :not_found unless @appointment
		end
	end
end