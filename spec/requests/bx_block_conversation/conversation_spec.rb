require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockConversation::Conversations", type: :request do
	let(:conversation) {create(:conversation)}
	let(:doctor) { create(:doctor) }
	let!(:appointment) { create(:appointment, account: doctor.account, healthcareable_type: doctor.account.role) }
	let(:token){ jwt_encode({ id: appointment.patient_id }) } 

  describe "GET /index" do
  end


  describe "GET /select_doc" do
    it "should show list of doctors to select for conversation" do
    	get "/bx_block_conversation/select_doc", headers: { "Authorization" => token }
    	value = JSON.parse(response.body)
    	expect(value["data"].first["id"]).to eq("#{doctor.account.id}")
    end
  end
end
