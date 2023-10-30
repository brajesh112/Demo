module BxBlockPrescription
	class Medicine < ApplicationRecord
		self.table_name = "medicines"
    validates :name, :description, presence: true
    has_many :instruction_prescriptions, class_name: "BxBlockPrescription::InstructionPrescription"
	end
end
