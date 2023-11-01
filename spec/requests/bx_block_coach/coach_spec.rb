require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockCoach::Coaches", type: :request do

  let!(:coach) {create(:coach)}
	let(:token) {jwt_encode({id: coach.account_id})}
	let(:url) { "/bx_block_coach/coaches" }

	let(:parameter) { { name: "Jack", practicing_from: "02/12/2023", professional_statement: "AIIMS Graduated", account_id: coach.account_id, start_time: "10:00", end_time: "13:00" } }

  describe "GET /index" do
  	it "should show all coaches details" do
  		get url
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"].first["attributes"]["name"]).to eq(coach.name)
  	end
  end

  describe "GET /show" do
  	it "should show current account coach profile" do
  		get url+"/:id", headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["name"]).to eq(coach.name)
  	end
  end
  describe "POST /create" do 
  	it "should create a new coach for current account" do
  		post url, params: parameter,  headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("201")
  		expect(value["data"]["attributes"]["name"]).to eq(parameter[:name])
  	end

  	it "should show error message" do
  		post url, headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("422")
  		expect(value["errors"].first).to eq("Name can't be blank")
  	end

  	it "should show some errors message" do
  		coach.account.update(role: "doctor")
  		post url, headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
      expect(value["error"]).to eql("Please Select Correct Role")
  	end
  end

  describe "PATCH /update" do
  	it "should update coach profile" do
  		patch url+"/:id", headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["data"]["attributes"]["name"]).to eq(coach.name)
  	end

  	it "should through some error" do
  		patch url+"/:id", headers:{"Authorization" => token},params:{name: nil}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("422")
  		expect(value["errors"].first).to eq("Name can't be blank")
  	end
  end
end
