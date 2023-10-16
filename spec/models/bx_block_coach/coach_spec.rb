require 'rails_helper'

RSpec.describe BxBlockCoach::Coach, type: :model do

  let(:account) do
		@account = create("AccountBlock::Account")
		@account.id
	end

	subject {BxBlockCoach::Coach.create(name: "ABC",practicing_from: "2008-02-20T00:00:00.000Z",professional_statement: "Graduated from AIIMS Bhopal", account_id: account)}

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

end
