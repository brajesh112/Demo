module BxBlockAppointment
	class Appointment < ApplicationRecord
		self.table_name = "appointments"
		belongs_to :patient, class_name: "BxBlockPatient::Patient"
		belongs_to :healthcareable, polymorphic: true
		belongs_to :slot, class_name: "BxBlockAppointment::Slot"
	end
end
