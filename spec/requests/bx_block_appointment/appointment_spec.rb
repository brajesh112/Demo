require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockAppointment::Appointments", type: :request do

	let(:url){ "/bx_block_appointment/appointments" }
	let(:doctor) { create(:doctor) }
	let!(:appointment) { create(:appointment, account: doctor.account, healthcareable_type: doctor.account.role) }
	let(:token){ jwt_encode({id: appointment.patient_id}) } 

	let(:slot) { create(:slot) }

	let(:parameter){ { account_id: doctor.account_id, slot_id: slot.id, date: "10/12/2023", status: "scheduled" } }

	let(:unautarized) { { account_id: doctor.account_id } }

	describe "GET /index" do
		it "should show appointments list for current user" do
			get url , headers: { "token" => token }
			value = JSON.parse(response.body)
			expect(value["data"].first["attributes"]["account_id"]).to eq(doctor.account_id)
		end
	end

  describe "GET /show" do
    it "should show appointment details" do
    	get url+"/#{appointment.id}", headers: {"token" => token }
    	value = JSON.parse(response.body)
   		expect(value["data"]["attributes"]["account_id"]).to eq(doctor.account_id)
    end
  end


  describe "POST /create" do
  	it "should create appointment with doctor" do
  		post url, headers: {"token" => token}, params: parameter
  		value = JSON.parse(response.body)
  		expect(value["data"]["attributes"]["account_id"]).to eq(doctor.account_id)
  	end

  	it "should show error message" do
  		post url, headers: {"token" => token}, params: unautarized
  		value = JSON.parse(response.body)
  		expect(value["error"].first).to eq("Slot must exist")
  	end

  	it "should suggest to select correct healthcare" do
  		post url, headers: {"token" => token}
  		value = JSON.parse(response.body)
  		expect(value["error"]).to eq("slot is already booked")
  	end
  end

  describe "PATCH /update" do
  	it "should update appointment details" do
  		patch url+"/#{appointment.id}", headers: {"token" => token }, params: {date: "12/10/2023", slot: slot.id}
  		value = JSON.parse(response.body)
  		expect(value["data"]["id"]).to eq("#{appointment.id}")
  	end

  	it "should show error message" do
  		patch url+"/#{appointment.id}", headers: {"token" => token }, params: {slot_id: ''}
  		value = JSON.parse(response.body)
  		expect(value["errors"].first).to eq("Slot must exist")
  	end

  	it "should suggest to select correct healthcare" do
  		patch url+"/#{appointment.id + 1}", headers: {"token" => token}
  		value = JSON.parse(response.body)
  		expect(value["error"]).to eq("Appointment does not exists")
  	end
  end

  describe "DELETE /destroy" do
  	it "should destroy appointment" do
  		delete url+"/#{appointment.id}", headers: {"token" => token}
  		value = JSON.parse(response.body)
  		expect(value["data"]["id"]).to eq("#{appointment.id}")
  	end

  	it "should show some error" do 
  		delete url+"/#{appointment.id + 1}", headers: {"token" => token}
  		value = JSON.parse(response.body)
  		expect(value["error"]).to eq("Appointment does not exists")
  	end
  end

  describe "GET /account" do
  	it "should show list of all doctors" do
  		get "/bx_block_appointment/accounts", headers: {"token" => token}
  		value = JSON.parse(response.body)
  		expect(value["data"].first["attributes"]["id"]).to eq(doctor.account_id)
  	end

  	let(:specialization) {create (:specialization)}
  	it "should show list of doctors form specific specialization" do
  		doctor.account.specializations << specialization
  		get "/bx_block_appointment/accounts", params: {query: "#{specialization.specialization_name}"}
  		value = JSON.parse(response.body)
  		expect(value["data"].first["attributes"]["id"]).to eq(doctor.account_id)
  	end
  end

  describe "GET /available_slot" do
  	let!(:slot1) {create(:slot, slot_time: "11:00")}
  	it "should show available slots for specific date and doctor" do
  		get "/bx_block_appointment/slots", params: {account_id: doctor.account_id, date: DateTime.now.to_date}
  		value = JSON.parse(response.body)
  		expect(value.first["id"]).to eq(slot1.id)
  	end

    it "should show error message when doctor is not found" do
      get "/bx_block_appointment/slots", params: {account_id: appointment.patient_id, date: DateTime.now.to_date}
      value = JSON.parse(response.body)
      expect(value["error"]).to eq("Doctor not found")
    end
  end
end
