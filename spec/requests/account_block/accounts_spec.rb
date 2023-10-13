require 'rails_helper'
include JwtToken
RSpec.describe "AccountBlock::Accounts", type: :request do
  	let(:url) do 
		"/account_block/accounts"
	end 

  let(:image) do
    fixture_file_upload(Rails.root.join('spec/photos/profile.png'), 'image/png')
  end

	let(:parameters) do 
		{first_name: "Jack", last_name: "Smith",email: "jsmith#{rand(0..111)}@sample.com", user_name: "jack_smith#{rand(0..111)}", password: "password", role: "staff", type: "email", gender: "male", phone_number: "789654135", profile_image: image } 
	end

	let(:parameter) do 
		{first_name: "Jack", last_name: "Smith",email: "jsmith#{rand(0..111)}@sample.com", user_name: "jack_smith#{rand(0..111)}", password: "password", role: "staff", type: "sms", gender: "male", phone_number: "789654135", profile_image: image} 
	end

	before do
	 	@account = create("AccountBlock::Account")
	 	 @token = jwt_encode({id: @account.id})
  end

  describe "GET /index" do
    it "show all accounts" do
    	get url
    	value = JSON.parse(response.body)
    	expect(response.code).to eq("200")
    	expect(value["data"].first["attributes"]["first_name"]).to eq(@account.first_name)
    end
  end

  describe "GET /show" do
  	it "show current account" do
  		get url + "/:id", headers: {"Authorization"=> @token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
    	expect(value["data"]["attributes"]["first_name"]).to eq(@account.first_name)
  	end
  end

  describe "POST /create" do
  	it "create new email account" do
  		post url, params: parameters
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("201")
    	expect(value["data"]["attributes"]["first_name"]).to eq(parameters[:first_name])
  	end

  	it "create new sms account" do
  		post url, params: parameter
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("201")
    	expect(value["data"]["attributes"]["first_name"]).to eq(parameter[:first_name])
  	end

  	it "shows errors messages" do
  		post url
  		expect(response.code).to eq("422")
  	end
  end

  describe "PATCH /update" do
  	it "update current account" do
  		patch url + "/:id", headers: {"Authorization"=> @token}, params: {password: @account.password}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
    	expect(value["data"]["attributes"]["password"]).to eq(@account.password)
  	end

  	it "shows errors messages" do 
  		patch url + "/:id", headers: {"Authorization"=> @token}
  		expect(response.code).to eq("422")
  	end
  end 

  describe "DELETE /destroy" do
  	it "delete current account" do 
  		delete url+ "/:id", headers: {"Authorization"=> @token}
  		value = JSON.parse(response.body)
  		expect(response.code).to eq("200")
    	expect(value["data"]["attributes"]["first_name"]).to eq(@account.first_name)
  	end
  end
end
