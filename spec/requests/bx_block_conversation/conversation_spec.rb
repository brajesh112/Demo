require 'rails_helper'
include JwtToken
RSpec.describe "BxBlockConversation::Conversations", type: :request do
	let(:conversation) {create(:conversation)}
	let(:doctor) { create(:doctor) }
	let!(:appointment) { create(:appointment, account: doctor.account, healthcareable_type: doctor.account.role) }
	let(:token){ jwt_encode({ id: appointment.patient_id }) }
  let(:token1) {jwt_encode({id: conversation.patient_id})} 
  let(:headers) { {'Accept'=>'application/json','Accept-Charset'=>'utf-8','Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3','Authorization'=>'Basic QUM5YzM4MzhjOWNlMDMxM2E2OGM1MDk0YTU0OGI4MDY4YjpkMDlmNTEzMzhiNmJiMzk0NDczYjQyZjllYjE0YmNjMg==','Content-Type'=>'application/x-www-form-urlencoded','User-Agent'=>'twilio-ruby/6.8.0 (linux x86_64) Ruby/3.1.2'} }

  describe "POST /create" do
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

  describe "GET /select_account" do
    it "should show list of accounts to continue conversation" do
    	get "/bx_block_conversation/select_account", headers: { "token" => token1 }
    	value = JSON.parse(response.body)
    	expect(value["data"].first["id"]).to eq("#{conversation.account.id}")
    end
  end

  describe "GET /select_new_account" do
    it "should show list of accounts to continue conversation" do
      get "/bx_block_conversation/select_new_account", headers: { "token" => token }
      value = JSON.parse(response.body)
      expect(value["data"].first["id"]).to eq("#{doctor.account.id}")
    end
  end

  describe "POST /send_message" do
    it "should send a message using twilio api" do
      stub_request(:post, "https://conversations.twilio.com/v1/Conversations/your_conversation_id/Messages").with(body: {"Author"=>"#{appointment.patient.user_name}", "Body"=>"hi"},headers: headers).to_return(status: 200, body: "", headers: {})
      post "/bx_block_conversation/send_message", headers: { "token" => token },
      params: {body: "hi", conversation_id: "your_conversation_id"}
      expect(response.code).to eq("200")
    end

    it "should show error" do
      allow(TwilioClient).to receive(:message).and_throw(StandardError)
      post "/bx_block_conversation/send_message", headers: { "token" => token },
      params: {body: "hi", conversation_id: "your_conversation_id"}
      value = JSON.parse(response.body)
      expect(value["error"]).to eq("uncaught throw StandardError")
    end
  end

  # describe "PATCH /update" do
  #   it "should search for a pre-existing conversation" do
  #     stub_request(:get, "https://conversations.twilio.com/v1/Conversations/MyString/Messages").with(headers: {'Accept'=>'application/json','Accept-Charset'=>'utf-8',
  #         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3','Authorization'=>'Basic QUM5YzM4MzhjOWNlMDMxM2E2OGM1MDk0YTU0OGI4MDY4YjpkMDlmNTEzMzhiNmJiMzk0NDczYjQyZjllYjE0YmNjMg==','User-Agent'=>'twilio-ruby/6.8.0 (linux x86_64) Ruby/3.1.2'
  #       }).to_return(status: 200, body: ["sid","my string"], headers: {})

  #     patch "/bx_block_conversation/conversations/:id", headers: { "token" => token1 }, params: {doc_id: conversation.account_id}
  #     value = JSON.parse(response.body)
  #     debugger
  #     expect(response.code).to eq("200")
  #   end
  # end
end

