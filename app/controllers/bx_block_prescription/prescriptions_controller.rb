module BxBlockPrescription 
	class PrescriptionsController < ApplicationController
		before_action :authenticate_request
		before_action :check_doctor, only: [:create]

		def index
			prescriptions = @current_account.role.eql?("patient") ?Prescription.where(patient_id: @current_account.id) : @current_account.prescriptions
			render json: BxBlockPrescription::PrescriptionSerializer.new(prescriptions).serializable_hash, status: :ok
		end

		def show
			prescription = Prescription.find_by(id: params[:id])
			render json: BxBlockPrescription::PrescriptionSerializer.new(prescription).serializable_hash, status: :ok
		end	

		def create 
			prescription = @current_account.prescriptions.new(prescription_params)
			if prescription.save
				render json: BxBlockPrescription::PrescriptionSerializer.new(prescription, meta: {message: "prescription created"}).serializable_hash, status: :created
			else
				render json: {errors: prescription.errors.full_messages}, status: :unprocessable_entity
			end
		end

		private 
		def prescription_params
			params.require(:prescription).permit(:duration, :quantity, :patient_id, instruction_prescriptions_attributes: [:id, :medicine_id, :instruction_id, :_destroy])
		end

		def check_doctor
			render json: {errors: "Your are not autharized for this action"}, status: :unauthorized unless @current_account.role.eql?('doctor')
		end
	end
end