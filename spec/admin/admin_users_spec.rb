require 'rails_helper'

RSpec.describe Admin::AdminUsersController, type: :controller do
  render_views
  set_admin_user

  let(:parameter) {{ admin_user: { email: "admin@example.com", password: "123456", password_confirmation: "123456" } } }

  let(:permitted_params) { { id: @adminuser.id, admin_user: {email: "brajesh@gmail.com", password: "123456", password_confirmation: "123456"} } }

  let(:unpermitted_params) { { id: @adminuser.id, admin_user: {email: '', password: "123456", password_confirmation: "123456" } } }

  describe "GET /index" do
  	it "should show all admin users" do
	  	get :index
	  	expect(response.code).to eq("200")
 		end

    it 'assigns the admin user' do
      get :index
      expect(assigns(:admin_users)).to include(@adminuser)
    end
  end

  describe "GET /show" do
    it "should display current admin user profile" do
      get :show, params: {id: @adminuser.id}
      expect(response.code).to eq("200")
    end
  end

  describe "POST /create" do
    it "should create new admin user" do
      post :create, params: parameter
      expect(AdminUser.count).to eq(2)
    end

    it "should not create new admin user" do
      post :create
      expect(AdminUser.count).to eq(1)
    end
  end

  describe "PUT /update" do
    it "should update admin user" do
      put :update, params: permitted_params
      expect(AdminUser.first.email).to eq("brajesh@gmail.com")
    end

    it "should not update admin user" do
      put :update, params: unpermitted_params
      expect(response.code).to eq("200")
    end
  end


  describe "DELETE /destroy" do
    it "should destroy current admin user" do
      delete :destroy, params: {id: @adminuser.id}
      expect(AdminUser.count).to eq(0)
    end
  end
end
