module BxBlockAppointment
	class Appointment < ApplicationRecord
		self.table_name = "appointments"
		belongs_to :patient, class_name: "AccountBlock::Account"
		belongs_to :account, class_name: "AccountBlock::Account"
		belongs_to :slot, class_name: "BxBlockAppointment::Slot"
		validates :date, :status,presence: true
		enum :status, [:scheduled, :completed, :canceled, :rescheduled, :refunded]
	end
end
