module BxBlockPayment 
	class PaymentsController < ApplicationController

		def create_payment
			order = RazorpayPayment.create_order(params[:amount], params[:id], params[:type])
			render json: order
		end
	end
end