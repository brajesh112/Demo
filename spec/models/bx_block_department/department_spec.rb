require 'rails_helper'

RSpec.describe BxBlockDepartment::Department, type: :model do
	subject { create(:department) }

	it "should be valid with valid attributes" do
		expect(subject).to be_valid
	end

  it "should not be valid without name" do
	 	subject.name = nil 
	 	expect(subject).to_not be_valid
  end
end
