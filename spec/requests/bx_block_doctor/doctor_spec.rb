require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockDoctor::Doctors", type: :request do
	let(:url) do
		"/bx_block_doctor/doctors"
	end

	let(:parameter) do 
		{name: "Jack", practicing_from: "02/12/2023", professional_statement: "AIIMS Graduated", department_id: @doctor.department_id, account_id: @doctor.account_id} 
	end

	before do 
		@doctor = create(:bx_block_doctor_doctor,:department,:account)
		@token = jwt_encode({id: @doctor.account.id}) 
	end

  describe "GET /index" do
    it "should show all doctors profiles" do
    	get url
    	value = JSON.parse(response.body)
    	expect(response.code).to eq("200")
    	expect(value["data"].first["attributes"]["name"]).to eq(@doctor.name)
    end
  end

  describe "GET /show" do
  	it "should show current doctors data" do
  		get url + "/:id", headers: {"Authorization"=> @token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
    	expect(value["data"]["attributes"]["name"]).to eq(@doctor.name)
  	end
  end

  describe "POST /create" do
  	it "should create current account's doctors profile" do
  		@doctor.account.update(role: 'doctor')
  		post url, params: parameter, headers: {"Authorization" =>@token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("201")
  		expect(value["data"]["attributes"]["name"]).to eq(parameter[:name])
  	end

  	it "should Show Errors" do
  		@doctor.account.update(role: 'doctor')
  		post url, headers: {"Authorization" => @token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("422")
  		expect(value["errors"].first).to eq("Department must exist")
  	end

  	it "should return plain text" do 
  		@doctor.account.update(role: 'coach')
  		post url, params: parameter, headers: {"Authorization" =>@token}
  		expect(response.body).to eql("Please Select Correct Role")
  	end
  end

  describe "PATCH /update" do
  	it "should update current doctors profile" do
  		patch url+"/:id",  headers: {"Authorization" => @token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["name"]).to eq(@doctor[:name])
  	end

  	it "should not update and show some errors" do 
  		patch url+"/:id", headers: {"Authorization" => @token}, params: {name: nil}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("422")
  		expect(value["errors"].first).to eq("Name can't be blank")
  	end
  end
end
