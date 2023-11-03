require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockPayment::Payments", type: :request do
	let(:doctor) {create(:doctor)}
	let(:appointment) { create(:appointment, account: doctor.account, healthcareable_type: doctor.account.role) }
	let(:token) {jwt_encode({id: appointment.patient_id})}
  describe "GET /create_payment" do
  	it "should create order for payment" do
  		allow(RazorpayPayment).to receive(:create_order).and_return({"id" => "Order#1"})
  		post "/bx_block_payment/create_payment" , headers: {token: token}
  		value = JSON.parse(response.body)
  		expect(value["order"]["id"]).to  eq("Order#1")
  	end
  end
end
