require 'rails_helper'

RSpec.describe Admin::SpecializationsController, type: :controller do
  render_views

  let(:parameter) do
  	{bx_block_specialization_specialization: {specialization_name: "new_specialization"}}
  end

  let(:permitted_attributes) do
  	 {id: @specialization.id,bx_block_specialization_specialization: {specialization_name: "new_specialization"}}
  end

  before do
  	@adminuser = create(:admin_user)
    sign_in @adminuser
    @specialization = create(:bx_block_specialization_specialization)
  end

  describe "GET /index" do
  	it "should render all specializations" do
  		get :index
  		expect(response.code).to eq("200")
  	end

  	it "assigns the specialization" do
  		get :index
  		expect(assigns(:specializations)).to include(@specialization)
  	end
  end

  describe "GET /show" do
  	it "should show specialization" do
  		get :show, params: {id: @specialization.id}
  		expect(response.code).to eq("200")
  	end
  end

  describe "POST /create" do
  	it "should create new specialization" do
  		post :create, params: parameter
  		expect(BxBlockSpecialization::Specialization.count).to eq(2)
  	end

  	it "should not create new specialization" do
  		post :create
  		expect(BxBlockSpecialization::Specialization.count).to eq(1)
  	end
  end
    describe "PUT /update" do
  	it "should update specialization name" do
  		put :update, params: permitted_attributes
  		expect(BxBlockSpecialization::Specialization.all.first.specialization_name).to eq("new_specialization")
  	end

  	it "should not update specialization name" do
  		put :update, params: {id: @specialization.id}
  		expect(BxBlockSpecialization::Specialization.all.first.specialization_name).to_not eq("123")
  	end
  end

  describe "DELETE /destroy" do
  	it "should destroy specialization" do
  		delete :destroy, params: {id: @specialization.id}
  		expect(BxBlockSpecialization::Specialization.count).to eq(0)
  	end
  end
end