module BxBlockPrescription
	class Prescription < ApplicationRecord
		self.table_name = "prescriptions"
		belongs_to :patient, class_name: "AccountBlock::Account"
		belongs_to :account, class_name: "AccountBlock::Account"
		validates :quantity, :duration, presence: true
		has_many :instruction_prescriptions, dependent: :destroy, class_name: "BxBlockPrescription::InstructionPrescription"
		accepts_nested_attributes_for :instruction_prescriptions
	end
end
