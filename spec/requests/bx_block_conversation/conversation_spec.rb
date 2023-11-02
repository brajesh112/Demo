require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockConversation::Conversations", type: :request do
	let(:conversation) {create(:conversation)}
	let(:doctor) { create(:doctor) }
	let!(:appointment) { create(:appointment, account: doctor.account, healthcareable_type: doctor.account.role) }
	let(:token){ jwt_encode({ id: appointment.patient_id }) }
  let(:token1) {jwt_encode({id: conversation.patient_id})} 

  describe "POST /create" do
    it "should search for a pre-existing conversation" do
      post "/bx_block_conversation/conversations", headers: { "token" => token1 }, params: {doc_id: conversation.account_id}
      value = JSON.parse(response.body)
      expect(value["data"].first["id"]).to eq("#{conversation.id}")
    end

    it "should call twilio apis to create conversation" do
      allow(TwilioClient).to receive(:create_conversation).and_return('your_conversation_id')
      allow(TwilioClient).to receive(:add_participant)
      post "/bx_block_conversation/conversations", headers: { "token" => token1 }, params: {doc_id: appointment.account_id}
      value = JSON.parse(response.body)
      expect(value["data"]["attributes"]["conversation_id"]).to eq('your_conversation_id')
    end

    it "should show error" do
      allow(TwilioClient).to receive(:create_conversation).and_throw(StandardError)
      post "/bx_block_conversation/conversations", headers: { "token" => token1 }, params: {doc_id: appointment.account_id}
      value = JSON.parse(response.body)
      expect(value["error"]).to eq("uncaught throw StandardError")
    end
  end


  describe "GET /select_doctor" do
    it "should show list of doctors to select for conversation" do
    	get "/bx_block_conversation/select_doctor", headers: { "token" => token }
    	value = JSON.parse(response.body)
    	expect(value["data"].first["id"]).to eq("#{doctor.account.id}")
    end
  end

  describe "POST /send_message" do
    it "should send a message using twilio api" do
      allow(TwilioClient).to receive(:message).and_return('hi')
      post "/bx_block_conversation/send_message", headers: { "token" => token },
      params: {body: "hi", conversation_id: "your_conversation_id"}
      value = JSON.parse(response.body)
      expect(value["message"]).to eq("hi")
    end

    it "should show error" do
      allow(TwilioClient).to receive(:message).and_throw(StandardError)
      post "/bx_block_conversation/send_message", headers: { "token" => token },
      params: {body: "hi", conversation_id: "your_conversation_id"}
      value = JSON.parse(response.body)
      expect(value["error"]).to eq("uncaught throw StandardError")
    end
  end
end