require 'rails_helper'

RSpec.describe AccountBlock::Account, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { AccountBlock::Account.new(first_name: "Jack", last_name: "Smith",email: "jsmith@sample.com", user_name: "jack_smith", password: "password", role: "staff", type: "AccountBlock::EmailAccount", gender: "male" )}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a first_name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last_name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user_name" do
    subject.user_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a role" do
    subject.role = nil 
    expect(subject).to_not be_valid
  end

  it "is valid on difined role" do
    expect(AccountBlock::Account.roles.include?(subject.role)).to eq(true)
  end

  it "is not valid without a gender" do
    subject.gender = nil 
    expect(subject).to_not be_valid
  end

  it "is not valid without a type" do
    subject.type = nil 
    expect(subject).to_not be_valid
  end

end
