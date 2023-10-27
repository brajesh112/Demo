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
      post "/bx_block_conversation/conversations", headers: { "Authorization" => token1 }, params: {doc_id: conversation.account_id}
      value = JSON.parse(response.body)
      expect(value["data"].first["id"]).to eq("#{conversation.id}")
    end

    it "should call twilio apis to create conversation" do
      allow(TwilioClient).to receive(:create_conversation).and_return('your_conversation_id')
      allow(TwilioClient).to receive(:add_participant)
      stub_request(:any, "https://api.cloudinary.com/v1_1/dknq3jgrr/image/upload").with(body: {"api_key"=>"965579635243566", "file"=>"profile20231027-15048-mv3hvq.png", "signature"=>"a12eb0f8bc65577dd2c73cba8dd733b28469139a", "timestamp"=>"1685699758"},headers: {'Accept'=>'*/*','Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3','Content-Length'=>'33017','Content-Md5'=>'BVqRl5JkZkoe4SuUU2ENgg==','Content-Type'=>'multipart/form-data;boundary=----RubyFormBoundaryGltk4HSYBEVsfZ4D','Host'=>'api.cloudinary.com','User-Agent'=>'CloudinaryRuby/1.27.0 (Ruby 3.1.2-p20)'}.to_json).to_return(status: 200, body: "Image upload Sucessfully".to_json, headers: {})
      post "/bx_block_conversation/conversations", headers: { "Authorization" => token1 }, params: {doc_id: appointment.account_id}
      debugger
    end
  end


  describe "GET /select_doc" do
    it "should show list of doctors to select for conversation" do
    	get "/bx_block_conversation/select_doc", headers: { "Authorization" => token }
    	value = JSON.parse(response.body)
    	expect(value["data"].first["id"]).to eq("#{doctor.account.id}")
    end
  end
end

         # body: {"api_key"=>"965579635243566", "file"=>"profile20231027-15048-mv3hvq.png", "signature"=>"a12eb0f8bc65577dd2c73cba8dd733b28469139a", "timestamp"=>"1685699758"},headers: {
         #  'Accept'=>'*/*',
         #  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         #  'Content-Length'=>'33017',
         #  'Content-Md5'=>'BVqRl5JkZkoe4SuUU2ENgg==',
         #  'Content-Type'=>'multipart/form-data; boundary=----RubyFormBoundaryGltk4HSYBEVsfZ4D',
         #  'Host'=>'api.cloudinary.com',
         #  'User-Agent'=>'CloudinaryRuby/1.27.0 (Ruby 3.1.2-p20)'
         #   }).
         # to_return(status: 200, body: "", headers: {})

         # (filename="profile20231027-15048-mv3hvq.png")
         # "signature a12eb0f8bc65577dd2c73cba8dd733b28469139a