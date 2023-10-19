require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockAppointment::Appointments", type: :request do

	let(:url){ "/bx_block_appointment/appointments" }
	let!(:appointment) { create(:appointment)}
	let(:appointment1) {create(:appointment, :coach)}
	let(:token){ jwt_encode({id: appointment.patient.account.id})} 
	# let(:token1){jwt_encode({id: appointment.healthcareable.account.id})}
	# let(:token2){jwt_encode({id: appointment1.healthcareable.account.id})}

	let(:slot) {create(:slot)}

	let(:parameter) do
		{doctor: appointment.healthcareable.id, slot: slot.id, date: "10/12/2023"}
	end

	let(:parameter1) do
		{coach: appointment1.healthcareable.id, slot: slot.id, date: "10/12/2023"}
	end

	let(:unautarized) do
		{coach: appointment1.healthcareable_id}
	end

  describe "GET /show" do

    it "should show appointment details" do
    	get url+"/#{appointment.id}", headers: {"Authorization" => token }
    	value = JSON.parse(response.body)
   		expect(value["data"]["attributes"]["healthcareable_id"]).to eq(appointment.healthcareable_id)
    end

    # it "should show appointment details for doctor" do
    # 	get url+"/#{appointment.id}", headers: {"Authorization" => token1}
    # 	value = JSON.parse(response.body)
    # 	expect(value["data"]["attributes"]["healthcareable_id"]).to eq(appointment.healthcareable_id)
    # end

    # it "should show appointment details for coach" do
    # 	get url+"/#{appointment1.id}", headers: {"Authorization" => token2}
    # 	value = JSON.parse(response.body)
    # 	expect(value["data"]["attributes"]["healthcareable_id"]).to eq(appointment1.healthcareable_id)
    # end
  end


  describe "POST /create" do
  	it "should create appointment with doctor" do
  		post url, headers: {"Authorization" => token}, params: parameter
  		value = JSON.parse(response.body)
  		expect(value["data"]["attributes"]["healthcareable_type"]).to eq("BxBlockDoctor")
  	end

  	it "should create appointment with coach" do
  		post url, headers: {"Authorization" => token}, params: parameter1
  		value = JSON.parse(response.body)
  		expect(value["data"]["attributes"]["healthcareable_type"]).to eq("BxBlockCoach::Coach")
  	end

  	it "should show error message" do
  		post url, headers: {"Authorization" => token}, params: unautarized
  		value = JSON.parse(response.body)
  		expect(value["errors"].first).to eq("Slot must exist")
  	end

  	it "should suggest to select correct healthcare" do
  		post url, headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(value["error"]).to eq("Select correct healthcare")
  	end
  end

  describe "PATCH /update" do
  	it "should update appointment details" do
  		patch url+"/#{appointment.id}", headers: {"Authorization" => token }, params: {date: "12/10/2023", slot: slot.id}
  		value = JSON.parse(response.body)
  		expect(value["data"]["id"]).to eq("#{appointment.id}")
  	end

  	it "should show error message" do
  		patch url+"/#{appointment.id}", headers: {"Authorization" => token }
  		value = JSON.parse(response.body)
  		expect(value["errors"].first).to eq("Slot must exist")
  	end

  	it "should suggest to select correct healthcare" do
  		post url, headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(value["error"]).to eq("Select correct healthcare")
  	end
  end
end
