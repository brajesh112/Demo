require 'rails_helper'

RSpec.describe Admin::DepartmentsController, type: :controller do
  render_views
  set_admin_user
  let(:parameter) { { bx_block_department_department: { name: "new_department" } } }

  let(:permitted_attributes){ { id: department.id,bx_block_department_department: { name: "new_department" } } }

  let!(:department) { create(:department) }

  describe "GET /index" do
  	it "should render all departments" do
  		get :index
  		expect(response.code).to eq("200")
  	end

  	it "assigns the department" do
  		get :index
  		expect(assigns(:departments)).to include(department)
  	end
  end

  describe "GET /show" do
  	it "should show department" do
  		get :show, params: {id: department.id}
  		expect(response.code).to eq("200")
  	end
  end

  describe "POST /create" do
  	it "should create new department" do
  		post :create, params: parameter
  		expect(BxBlockDepartment::Department.count).to eq(2)
  	end

  	it "should not create new department" do
  		post :create
  		expect(BxBlockDepartment::Department.count).to eq(1)
  	end
  end

  describe "PUT /update" do
  	it "should update department name" do
  		put :update, params: permitted_attributes
  		expect(BxBlockDepartment::Department.all.first.name).to eq("new_department")
  	end

  	it "should not update department name" do
  		put :update, params: {id: department.id}
  		expect(BxBlockDepartment::Department.all.first.name).to_not eq("123")
  	end
  end

  describe "DELETE /destroy" do
  	it "should destroy department" do
  		delete :destroy, params: {id: department.id}
  		expect(BxBlockDepartment::Department.count).to eq(0)
  	end
  end
end
