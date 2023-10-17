require 'rails_helper'

RSpec.describe BxBlockSpecialization::Specialization, type: :model do
 	subject {BxBlockSpecialization::Specialization.create(specialization_name: "new_specialization")}

	it "should be valid with valid attributes" do
		expect(subject).to be_valid
	end

  it "should not be valid without name" do
	 	subject.specialization_name = nil 
	 	expect(subject).to_not be_valid
  end
end
