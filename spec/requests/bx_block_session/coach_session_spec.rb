require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockSession::CoachSessions", type: :request do
  
  let(:url) {"/bx_block_session/coach_sessions"}
  let!(:coach_session) {create(:coach_session)}
  let(:token) {jwt_encode({id: coach_session.account_id})}
  let(:parameter) { { notes: "agvcjh", start_time: "10:00", end_time: "13:00", entery_fee: "200", fees: "400", status: "available", type: 'personal'} }

  let(:parameter1) { { notes: "agvcjh", start_time: "10:00", end_time: "13:00", entery_fee: "200", fees: "400", status: "available", type: 'public'} }

  describe "GET /index" do
  	it "should show all coach_sessions of current account" do
  		get url, headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(value["data"].first["id"]).to eq("#{coach_session.id}")
  	end
  end

  describe "GET /show" do
  	it "should show specific coach session of current account" do
  		get url+"/#{coach_session.id}", headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(value["data"]["id"]).to eq("#{coach_session.id}")
  	end
  end

  describe "POST /create" do
  	let(:account) {create(:account, :doctor)}
  	let(:token1) {jwt_encode({id: account.id})}
  	it "should create new personal coach session of current account" do
  		post url, params: parameter, headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(value["data"]["attributes"]["notes"]).to eq(parameter[:notes])
  	end

  	it "should create new public coach session of current account" do
  		post url, params: parameter1, headers: {"Authorization" => token}
  		value = JSON.parse(response.body)
  		expect(value["data"]["attributes"]["notes"]).to eq(parameter[:notes])
  	end

  	it "should show warning you are not allowed" do
  		post url,params: parameter1, headers: {"Authorization" => token1}
  		value =JSON.parse(response.body)
  		expect(value["errors"]).to eq("Your are not autharized for this action")
  	end
  end

  describe "PATCH /update" do
  	it "should update coach session" do
	  	patch url+"/#{coach_session.id}", headers: {"Authorization" => token}, params: parameter
	  	value = JSON.parse(response.body)
	  	expect(value["data"]["id"]).to eq("#{coach_session.id}")
	  end
	end

	describe "DELETE /destroy" do
		it "should delete coach session" do
			delete url+"/#{coach_session.id}", headers: {"Authorization" => token}
			value = JSON.parse(response.body)
		  	expect(value["data"]["id"]).to eq("#{coach_session.id}")
	  end
	end
end
