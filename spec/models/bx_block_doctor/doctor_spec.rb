require 'rails_helper'

RSpec.describe BxBlockDoctor::Doctor, type: :model do
	
	subject {create(:doctor)}

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

	it "should not be valid without start_time" do
		subject.start_time = nil
		expect(subject).to_not be_valid
	end

	it "should not be valid without end time" do
		subject.end_time = nil
		expect(subject).to_not be_valid
	end

	it "should not be valid if end time is less than start time" do
		subject.start_time = "12:15"
		subject.end_time = "10:00"
		expect(subject).to_not be_valid
	end

end