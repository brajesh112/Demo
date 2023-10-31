module BxBlockPrescription 
	class PrescriptionsController < ApplicationController
		before_action :authenticate_request

		def index
			prescription = @current_account.role.eql?("patient") ?Prescription.where(patient_id: @current_account.id) : @current_account.prescription
		end

		def show
			prescription = Prescription.find_by(id: params[:id])
		end	

		def create 
			debugger
			prescription = @current_account.prescriptions.create(prescription_params)
			debugger
		end



		private 
		def prescription_params
			params.require(:prescription).permit(:duration, :quantity, :patient_id, instruction_prescriptions_attributes: [ :medicine_id, :instruction_id])
		end
	end
end