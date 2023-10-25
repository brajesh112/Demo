# module BxBlockPrescription 
# 	class PrescriptionsController < ApplicationController
# 		before_action :authenticate_request

# 		def index
# 			prescription = @current_account.role.eql?("patient") ?Prescription.where(patient_id: @current_account.id) : @current_account.prescription
# 		end

# 		def show
# 			prescription = Prescription.find_by(id: params[:id])
# 		end	

# 		def create 
			
# 		end
# 	end
# end