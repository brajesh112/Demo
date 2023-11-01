module BxBlockPrescription 
	class PrescriptionsController < ApplicationController
		before_action :authenticate_request
		before_action :check_doctor, only: [:create]

		def index
			prescriptions = @current_account.role.eql?("patient") ?Prescription.where(patient_id: @current_account.id) : @current_account.prescriptions
			if prescriptions.present?
				render json: BxBlockPrescription::PrescriptionSerializer.new(prescriptions, meta: {message: "Index action"}).serializable_hash, status: :ok 
			else
				render json: {error: "The prescription you are looking for does not exists"}
			end
		end

		def show
			prescription = Prescription.find_by(id: params[:id])
			if prescription
				render json: BxBlockPrescription::PrescriptionSerializer.new(prescription, meta: {message: "Show action"}).serializable_hash, status: :ok 
			else
				render json: {error: "The prescription you are looking for does not exists"}
			end
		end	

		def create 
			prescription = @current_account.prescriptions.new(prescription_params)
			if prescription.save
				render json: BxBlockPrescription::PrescriptionSerializer.new(prescription, meta: {message: "prescription created"}).serializable_hash, status: :created
			else
				render json: {errors: prescription.errors.full_messages}
			end
		end

		private 
		def prescription_params
			params.require(:prescription).permit(:duration, :quantity, :patient_id, instruction_prescriptions_attributes: [ :medicine_id, :instruction_id])
		end

		def check_doctor
			unless @current_account.role.eql?('doctor')
				render json: {errors: "Your are not autharized for this action"}
			end
		end
	end
end