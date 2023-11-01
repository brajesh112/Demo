module BxBlockPrescription
	class Instruction < ApplicationRecord
		self.table_name = "instructions"
		has_many :instruction_prescriptions, dependent: :destroy, class_name: "BxBlockPrescription::InstructionPrescription"
	end
end
