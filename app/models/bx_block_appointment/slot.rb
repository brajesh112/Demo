module BxBlockAppointment
	class Slot < ApplicationRecord
		self.table_name = "slots"
		has_many :appointments, class_name: "BxBlockAppointment::Appointment"
		validates :slot_time, presence: true
	end
end