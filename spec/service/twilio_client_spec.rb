require 'rails_helper'

RSpec.describe TwilioClient do
  let(:account) {create(:account, :doctor)}
  let(:patient) {create(:account, :patient)}
  let(:headers) { {'Accept'=>'application/json','Accept-Charset'=>'utf-8','Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3','Authorization'=>'Basic QUM5YzM4MzhjOWNlMDMxM2E2OGM1MDk0YTU0OGI4MDY4YjpkMDlmNTEzMzhiNmJiMzk0NDczYjQyZjllYjE0YmNjMg==','Content-Type'=>'application/x-www-form-urlencoded','User-Agent'=>'twilio-ruby/6.8.0 (linux x86_64) Ruby/3.1.2'} }
  let(:c_id) {"mocked_conversation_id"}

  describe '.create_conversation' do
    it 'creates a conversation' do
      stub_request(:post, "https://conversations.twilio.com/v1/Conversations").
      with(body: {"FriendlyName"=>"Friendly Conversation"},
        headers: headers).to_return(status: 200, body: {sid: "conversation_id"}.to_json, headers: {})
      conversation_id = TwilioClient.create_conversation
      expect(conversation_id).to eq('conversation_id')
    end
  end

  describe '.add_participant' do
    it 'adds a patient and a doctor as participants' do
      stub_request(:post, "https://conversations.twilio.com/v1/Conversations/mocked_conversation_id/Participants").with(body: {"Attributes"=>"{\"role\":\"patient\",\"user_name\":\"#{patient.user_name}\"}", "Identity"=>"#{patient.id}"},
        headers: headers).to_return(status: 200, body:{sid: "conversation_id"}.to_json, headers: {})
      stub_request(:post, "https://conversations.twilio.com/v1/Conversations/mocked_conversation_id/Participants").with(body: {"Attributes"=>"{\"role\":\"doctor\",\"user_name\":\"#{account.user_name}\"}", "Identity"=>"#{account.id}"},
        headers: headers).to_return(status: 200, body: {sid: "conversation_id"}.to_json, headers: {})
      conversation_id = TwilioClient.add_participant(c_id, patient, account)
      expect(conversation_id.class.name).to eq("Twilio::REST::Conversations::V1::ConversationContext::ParticipantInstance")
    end
  end

  describe '.message' do
    it 'sends a message and returns its body' do
      body = 'Hello, this is a test message'
      stub_request(:post, "https://conversations.twilio.com/v1/Conversations/mocked_conversation_id/Messages").with(body: {"Author"=>"#{patient.user_name}", "Body"=>"#{body}"},headers: headers).to_return(status: 200, body: {sid: "#{body}"}.to_json, headers: {})
      result = TwilioClient.message(c_id, patient.user_name, body)
      debugger
    end
  end
end
