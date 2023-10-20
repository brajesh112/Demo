require 'rails_helper'

RSpec.describe Admin::DepartmentsController, type: :controller do
  render_views

  let(:parameter) do
  	{bx_block_department_department: {name: "new_department"}}
  end

  let(:permitted_attributes) do
  	{id: @department.id,bx_block_department_department: {name: "new_department"}}
  end

  before do
  	@adminuser = create(:admin_user)
    sign_in @adminuser
    @department = create(:department)
  end

  describe "GET /index" do
  	it "should render all departments" do
  		get :index
  		expect(response.code).to eq("200")
  	end

  	it "assigns the department" do
  		get :index
  		expect(assigns(:departments)).to include(@department)
  	end
  end

  describe "GET /show" do
  	it "should show department" do
  		get :show, params: {id: @department.id}
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
  		put :update, params: {id: @department.id}
  		expect(BxBlockDepartment::Department.all.first.name).to_not eq("123")
  	end
  end

  describe "DELETE /destroy" do
  	it "should destroy department" do
  		delete :destroy, params: {id: @department.id}
  		expect(BxBlockDepartment::Department.count).to eq(0)
  	end
  end
end
