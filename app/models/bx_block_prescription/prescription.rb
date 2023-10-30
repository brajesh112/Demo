module BxBlockPrescription
	class Prescription < ApplicationRecord
		self.table_name = "prescriptions"
		has_many :medicines, class_name: "BxBlockPrescription::Medicine"
		belongs_to :patient, class_name: "AccountBlock::Account"
		belongs_to :account, class_name: "AccountBlock::Account"
		validates :quantity, :duration, presence: true
		has_many :instruction_prescriptions, class_name: "BxBlockPrescription::InstructionPrescription"
	end
end
