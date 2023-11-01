require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockDoctor::Doctors", type: :request do

	let(:url) { "/bx_block_doctor/doctors" }

	let(:parameter) { { name: "Jack", practicing_from: "02/12/2023", professional_statement: "AIIMS Graduated", department_id: doctor.department_id, account_id: doctor.account_id,start_time: "10:00", end_time: "13:00" } } 
	
  let!(:doctor) { create(:doctor) }
	let(:token) { jwt_encode({id: doctor.account_id}) }

  describe "GET /index" do
    it "should show all doctors profiles" do
    	get url
    	value = JSON.parse(response.body)
    	expect(response.code).to eq("200")
    	expect(value["data"].first["attributes"]["name"]).to eq(doctor.name)
    end
  end

  describe "GET /show" do
  	it "should show current doctors data" do
  		get url + "/:id", headers: {"Authorization"=> token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
    	expect(value["data"]["attributes"]["name"]).to eq(doctor.name)
  	end
  end

  describe "POST /create" do
  	it "should create current account's doctors profile" do
  		post url, params: parameter, headers: {"Authorization" =>token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("201")
  		expect(value["data"]["attributes"]["name"]).to eq(parameter[:name])
  	end

  	it "should Show Errors" do
  		post url, headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("422")
  		expect(value["errors"].first).to eq("Department must exist")
  	end

  	it "should return some error message" do 
  		doctor.account.update(role: 'coach')
  		post url, params: parameter, headers: {"Authorization" =>token}
      value = JSON.parse(response.body)
  		expect(value["error"]).to eql("Please Select Correct Role")
  	end
  end

  describe "PATCH /update" do
  	it "should update current doctors profile" do
  		patch url+"/:id",  headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["name"]).to eq(doctor[:name])
  	end

  	it "should not update and show some errors" do 
  		patch url+"/:id", headers: {"Authorization" => token}, params: {name: nil}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("422")
  		expect(value["errors"].first).to eq("Name can't be blank")
  	end
  end
end
