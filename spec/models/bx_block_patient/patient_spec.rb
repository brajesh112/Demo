require 'rails_helper'

RSpec.describe BxBlockPatient::Patient, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:account) do
  	@account = create("AccountBlock::Account")
		@account.id
  end

  subject {BxBlockPatient::Patient.create(first_name: "abc", last_name: "xyz", age: 18, phone_number: 789641236, email: "abc@email.com", gender: "male", address: "xyz compartment", account_id: account)}

  it "should not be valid without first_name" do
  	subject.first_name = nil
  	expect(subject).to_not be_valid
  end

  it "should be valid with valid attributes" do
  	expect(subject).to be_valid
  end

  it "should not be valid without last_name" do
  	subject.last_name = nil
  	expect(subject).to_not be_valid
  end

  it "should not be valid without age" do
  	subject.age = nil
  	expect(subject).to_not be_valid
  end

  it "should not be valid without phone_number" do
  	subject.phone_number = nil
  	expect(subject).to_not be_valid
  end

  it "should not be valid without gender" do
  	subject.gender = nil
  	expect(subject).to_not be_valid
  end

  it "should not be valid without email" do
  	subject.email = nil
  	expect(subject).to_not be_valid
  end

  it "should not be valid without address" do
  	subject.address = nil
  	expect(subject).to_not be_valid
  end

end
