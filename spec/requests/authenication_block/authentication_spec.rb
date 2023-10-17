require 'rails_helper'

RSpec.describe "AuthenicationBlock::Authentications", type: :request do
	let(:url) do
		"/authentication_block/login"
	end
	let(:parameter) do
		{email: @account.email, password: @account.password}
	end

	before do
		@account = create("AccountBlock::Account")
	end

  describe "POST /login" do
  	it "should authenticate user and generate token" do
  		post url, params: parameter
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
  		expect(value["token"].present?).to eq(true)
  	end

  	it "should return some error message" do
  		post url, params: {email: ''}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("401")
  		expect(value["error"]).to eq("unauthorized")
  	end
  end
end
