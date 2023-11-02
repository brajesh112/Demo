module BxBlockPatient
	class PatientsController < ApplicationController
		before_action :authenticate_request
		before_action :find_patient, only: [:show, :update, :destroy]
		
		def index
			patients = Patient.all 
			render json: BxBlockPatient::PatientSerializer.new(patients, meta: {message: "Index Action"}).serializable_hash, status: :ok if patients
		end

		def show	
			render json: BxBlockPatient::PatientSerializer.new(@patient, meta: {message: "Show Action"}).serializable_hash, status: :ok 
		end

		def create
			patient = 	@current_account.present? ? @current_account.build_patient(patient_params) : Patient.new(patient_params)
			if patient.save
				render json: BxBlockPatient::PatientSerializer.new(patient, meta: {message: "Profile Created"}).serializable_hash, status: :created
			else
				render json: {errors: patient.errors.full_messages}, status: :unprocessable_entity
			end
		end

		def update
			if @patient.update(patient_params)
				render json: BxBlockPatient::PatientSerializer.new(@patient, meta: {message: "Profile Updated"}).serializable_hash,status: :ok
			else
				render json: {errors: @patient.errors.full_messages}, status: :unprocessable_entity
			end
		end

		def destroy
			@patient.destroy
			render json: BxBlockPatient::PatientSerializer.new(@patient, meta: {message: "Profile deleted"}).serializable_hash, status: :ok
		end


		private
			def patient_params
				params.permit(:first_name, :last_name, :gender, :phone_number, :email, :age, :address)
			end

			def find_patient
				@patient = @current_account.present? ? @current_account.patient : Patient.find_by(id: params[:id])
				return render json: {error: "Patient not found"}, status: :not_found unless @patient.present?
			end
	end
end