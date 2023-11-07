require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockPayment::Payments", type: :request do
	let(:doctor) {create(:doctor)}
	let(:appointment) { create(:appointment, account: doctor.account, healthcareable_type: doctor.account.role) }
	let(:token) {jwt_encode({id: appointment.patient_id})}
  describe "GET /create_payment" do
  	it "should create order for payment" do
      stub_request(:post, "https://api.razorpay.com/v1/orders").
      with(body: "amount=&currency=INR&receipt=TEST%23",headers: {'Accept'=>'*/*','Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3','Authorization'=>'Basic cnpwX3Rlc3RfTXEzZHBGNDdCc3dTSFk6TGdLSlRrUUx1ZzFBdGtUWVNickM2MllW','User-Agent'=>'Razorpay-Ruby/3.1.0; Ruby/3.1.2'
       }).to_return(status: 200, body: "", headers: {})
  		post "/bx_block_payment/create_payment" , headers: {token: token}
  		value = JSON.parse(response.body)
  		expect(response.code).to  eq("200")
  	end
  end
end
