require 'rails_helper'

RSpec.describe BxBlockPrescription::Medicine, type: :model do
 	subject {BxBlockPrescription::Medicine.create(name: "paracetamol", description: "this medicine is use for mild fever")}

 	it "should be valid with valid attributes" do
 		expect(subject).to be_valid
 	end

 	it "should not be valid without name" do
 		subject.name = nil 
 		expect(subject).to_not be_valid
 	end

 	it "should not be valid without description" do
 		subject.description = nil
 		expect(subject).to_not be_valid
 	end
 	
end
