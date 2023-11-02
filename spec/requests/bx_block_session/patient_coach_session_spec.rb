require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockSession::PatientCoachSessions", type: :request do
  let(:url) {"/bx_block_session/patient_coach_sessions"}
  let!(:session) {create(:session)}
  let!(:patient_session) {create(:patient_coach_session)}
  let(:token) {jwt_encode({id: patient_session.patient_id})}
  let(:parameter) { { coach_session_id: patient_session.coach_session_id, date: DateTime.now, account_id: patient_session.account_id,session_id: patient_session.session_id , payment_status: "paid" } }
  let(:coach_session) {create(:coach_session, type: "BxBlockSession::PrivateSession")}
	let(:coach_session1) {create(:coach_session)}

  let(:available_session_params) {{date: patient_session.date, coach_session_id:patient_session.coach_session_id, coach_id: patient_session.account_id}}

   let(:available_session_params1) {{date: patient_session.date, coach_session_id:coach_session.id, coach_id: patient_session.account_id}}

  describe "GET /index" do
  	it "should show all coach_sessions" do
  		get url, headers: {"token" => token}
  		value = JSON.parse(response.body)
  		expect(value["data"].first["id"]).to eq("#{patient_session.id}")
  	end
  end

  describe "GET /show" do
  	it "should show specific coach session of current account" do
  		get url+"/#{patient_session.id}", headers: {"token" => token}
  		value = JSON.parse(response.body)
  		expect(value["data"]["id"]).to eq("#{patient_session.id}")
  	end
  end

  describe "POST /create" do
  	it "should create patient session of current account" do
  		post url, params: parameter, headers: {"token" => token}
  		value = JSON.parse(response.body)
  		expect(value["data"]["attributes"]["notes"]).to eq(parameter[:notes])
  	end
  end

 #  describe "PATCH /update" do
 #  	it "should update coach session" do
	#   	patch url+"/#{patient_session.id}", headers: {"token" => token}, params: parameter
	#   	value = JSON.parse(response.body)
	#   	expect(value["data"]["id"]).to eq("#{patient_session.id}")
	#   end
	# end

	# describe "DELETE /destroy" do
	# 	it "should delete coach session" do
	# 		delete url+"/#{patient_session.id}", headers: {"token" => token}
	# 		value = JSON.parse(response.body)
	# 	  	expect(value["data"]["id"]).to eq("#{patient_session.id}")
	#   end
	# end

	describe "GET /coach_session_id" do
		it "should show coach sessions type for private sessions" do
			get "/bx_block_session/coach_session_id", params: {coach_id: coach_session.account_id}
			value = JSON.parse(response.body)
			expect(value["data"].first["attributes"]["notes"]).to eq("This is for testing purpose only")
		end

		it "should show coach sessions type for public sessions" do
			get "/bx_block_session/coach_session_id", params: {coach_id: coach_session1.account_id}
			value = JSON.parse(response.body)
			expect(value["data"].first["attributes"]["notes"]).to eq("This is for testing purpose only")
		end
	end

	describe "GET /show_coach" do
		it "should show list of coaches" do
			get "/bx_block_session/show_coach"
			value =JSON.parse(response.body)
			expect(value["data"].first["id"]).to eq("#{patient_session.account_id}")
		end
	end

	describe "GET /available_session" do
		it "should show available_sessions for public session" do
			get "/bx_block_session/available_sessions", params:available_session_params
			value =JSON.parse(response.body)
			expect(value["data"].first["id"]).to eq("#{session.id}")
		end

		it "should show available_sessions for private session" do
			get "/bx_block_session/available_sessions", params:available_session_params1
			value =JSON.parse(response.body)
			expect(value["data"].first["id"]).to eq("#{session.id}")
		end

	end

end
