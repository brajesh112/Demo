require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockPrescription::Prescriptions", type: :request do
  
  let(:prescription) { create(:prescription) }
  let(:medicine) { create(:medicine) }
  let(:instruction) { create (:instruction) }
  let(:url) { "/bx_block_prescription/prescriptions" }
  let(:token) {  jwt_encode({ id: prescription.account_id }) }
  let(:parameter) { {"prescription": {"quantity": "#{prescription.quantity}","duration": "2","patient_id": "#{prescription.patient_id}","instruction_prescriptions_attributes": {"0": {"medicine_id": "#{medicine.id}","instruction_id": "#{instruction.id}"}} } } }

  let(:unpermitted) { {"prescription": {"quantity": "#{prescription.quantity}","duration": "2","patient_id": "#{prescription.patient_id}","instruction_prescriptions_attributes": {"0": {"medicine_id": "#{medicine.id+1}","instruction_id": "#{instruction.id}"}} } } }

  describe "GET /index" do
	  it "should show all prescription" do
	  	get url, headers: {"Authorization"=> token}
			value = JSON.parse(response.body)
    	expect(response.code).to eq("200")
    	expect(value["data"].first["attributes"]["quantity"]).to eq(prescription.quantity) 
	  end

	  it "should show error message" do
	  	prescription.destroy
	  	get url, headers: {"Authorization"=> token}
			value = JSON.parse(response.body)
			expect(value["error"]).to eq("The prescription you are looking for does not exists") 
    end
  end

  describe "GET /show" do
  	it "should show specific prescription" do
  		get url+"/#{prescription.id}", headers: {"Authorization"=> token}
  		value = JSON.parse(response.body)
    	expect(response.code).to eq("200")
    	expect(value["data"]["attributes"]["quantity"]).to eq(prescription.quantity)
    end

    it "should show error message" do
	  	get url+"/#{prescription.id+1}", headers: {"Authorization"=> token}
			value = JSON.parse(response.body)
			expect(value["error"]).to eq("The prescription you are looking for does not exists") 
    end
  end

  describe "POST /create" do
  	it "should create new prescription" do
	  	post url, headers: {"Authorization"=> token}, params: parameter
	  	value = JSON.parse(response.body)
	  	expect(value["data"]["attributes"]["quantity"]).to eq(prescription.quantity)
	  end

	  it "should show error message" do
	  	post url, headers: {"Authorization"=> token}, params: unpermitted
	  	value = JSON.parse(response.body)
	  	expect(value["errors"].first).to eq("Instruction prescriptions medicine must exist")
	  end

	  it "should return because of user not autharized" do
	  	prescription.account.update(role: 'patient')
	  	post url, headers: {"Authorization"=> token}, params: parameter
	  	value = JSON.parse(response.body)
	  	expect(value["errors"]).to eq("Your are not autharized for this action")
	  end
	end
end
