require 'rails_helper'

RSpec.describe AdminUser, type: :model do
	subject {AdminUser.create(email: "admin@email.com", password: "123456", password_confirmation: "123456")}

	it "should be valid with valid attributes" do
		expect(subject).to be_valid
	end

  it "should not be valid without name" do
	 	subject.email = nil 
	 	expect(subject).to_not be_valid
  end
end
