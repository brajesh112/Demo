require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockPatient::Patients", type: :request do

	let(:url) { "/bx_block_patient/patients" }

	let(:parameter) { { first_name: "abc", last_name: "xyz", age: rand(0..100), phone_number: 789654126, gender: "male", address: "abc compartment", email: "abc@email.com" } }

	let!(:patient) { create(:patient) }
	let(:token) { jwt_encode({id: patient.account_id}) }

  describe "GET /index" do
  	it "should display all records" do
  		get url 
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"].first["attributes"]["first_name"]).to eq(patient.first_name)
  	end
  end

  describe "GET /show" do
  	it "should display profile of current patient using headers" do
  		get url + "/:id", headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["first_name"]).to eq(patient.first_name)
  	end

  	it "should display profile of current patient using patient id" do
  		get url + "/#{patient.id}"
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["first_name"]).to eq(patient.first_name)
  	end
  end

  describe "POST /create" do
  	it "should create new patient profile" do
  		post url, params: parameter
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("201")
  		expect(value["data"]["attributes"]["first_name"]).to eq(parameter[:first_name])
  	end

  	it "should create new patient using token" do
  		post url, headers: {"Authorization" => token}, params: parameter
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("201")
  		expect(value["data"]["attributes"]["first_name"]).to eq(parameter[:first_name])
  	end

  	it "should display some errors" do
  		post url
  		value = JSON.parse(response.body)
  		expect(value["errors"].first).to eq("First name can't be blank")
  	end
  end

  describe "PATCH /update" do
  	it "should update current patient profile using token" do
  		patch url + "/:id", headers: { "Authorization" => token }
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["first_name"]).to eq(patient[:first_name])
  	end

  	it "should update current patient profile using id" do
  		patch url + "/#{patient.id}"
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["first_name"]).to eq(patient[:first_name])
  	end

  	it "should display errors" do
  		patch url + "/#{patient.id}", params: {first_name: nil}
  		value = JSON.parse(response.body)
  		expect(value["errors"].first).to eq("First name can't be blank")
  	end
  end


  describe "DELETE /destroy" do
    it "should destroy profile of current patient using headers" do
      delete url + "/:id", headers: {"Authorization" => token}
      value = JSON.parse(response.body)
      expect(response.code).to eq("200")
      expect(value["data"]["attributes"]["first_name"]).to eq(patient.first_name)
    end

    it "should destroy profile of current patient using patient id" do
      delete url + "/#{patient.id}"
      value = JSON.parse(response.body)
      expect(response.code).to eq("200")
      expect(value["data"]["attributes"]["first_name"]).to eq(patient.first_name)
    end
  end
end
