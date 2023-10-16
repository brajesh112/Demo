require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockCoach::Coaches", type: :request do

	let(:url) do
		"/bx_block_coach/coaches"
	end

	let(:parameter) do
		{name: "Jack", practicing_from: "02/12/2023", professional_statement: "AIIMS Graduated", account_id: @coach.account_id} 
	end

	before do
		@coach = create(:bx_block_coach_coach, :account)
		@token = jwt_encode({id: @coach.account.id})
	end

  describe "GET /index" do
  	it "should show all coaches details" do
  		get url
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"].first["attributes"]["name"]).to eq(@coach.name)
  	end
  end

  describe "GET /show" do
  	it "should show current account coach profile" do
  		get url+"/:id", headers: {"Authorization" => @token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["name"]).to eq(@coach.name)
  	end
  end
  describe "POST /create" do 
  	it "should create a new coach for current account" do
  		@coach.account.update(role: "coach")
  		post url, params: parameter,  headers: {"Authorization" => @token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("201")
  		expect(value["data"]["attributes"]["name"]).to eq(parameter[:name])
  	end

  	it "should show error message" do
  		@coach.account.update(role: "coach")
  		post url, headers: {"Authorization" => @token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("422")
  		expect(value["errors"].first).to eq("Name can't be blank")
  	end

  	it "should show some plain text" do
  		@coach.account.update(role: "doctor")
  		post url, headers: {"Authorization" => @token}
  		expect(response.body).to eq("Please Select Correct Role")
  	end
  end

  describe "PATCH /update" do
  	it "should update coach profile" do
  		patch url+"/:id", headers: {"Authorization" => @token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["name"]).to eq(@coach.name)
  	end

  	it "should through some error" do
  		patch url+"/:id", headers:{"Authorization" => @token},params:{name: nil}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("422")
  		expect(value["errors"].first).to eq("Name can't be blank")
  	end
  end
end
