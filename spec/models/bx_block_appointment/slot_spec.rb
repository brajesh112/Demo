require 'rails_helper'

RSpec.describe BxBlockAppointment::Slot, type: :model do
	subject {create(:slot)}

	it "should be valild with valid attributes" do
		expect(subject).to be_valid
	end

	it "should be invalid without slot time" do
		subject.slot_time = nil
		expect(subject).to_not be_valid
	end
end
