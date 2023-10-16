require 'rails_helper'

RSpec.describe BxBlockDoctor::Doctor, type: :model do
	let(:account) do
		@account = create("AccountBlock::Account")
		@account.id
	end 

	let(:department) do
		@department = create("bx_block_department_department")
		@department.id
	end
	
	subject {BxBlockDoctor::Doctor.create(name: "jack",practicing_from: "2008-02-20T00:00:00.000Z",professional_statement: "Graduated from AIIMS Bhopal", department_id: department, account_id: account)}

	it "should be valid with valid attributes" do
		expect(subject).to be_valid
	end

	it "should not be valid without name" do
		subject.name = nil
		expect(subject).to_not be_valid
	end

	it "should not be valid without practicing_from" do
		subject.practicing_from = nil
		expect(subject).to_not be_valid
	end

	it "should not be valid without professional_statement" do
		subject.professional_statement = nil
		expect(subject).to_not be_valid
	end

	it "should not be valid without department" do
		subject.department_id = nil
		expect(subject).to_not be_valid
	end 

	it "should not be valid without Account" do
		subject.account_id = nil
		expect(subject).to_not be_valid
	end 

end