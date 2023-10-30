module BxBlockPrescription
	class InstructionPrescription < ApplicationRecord
		self.table_name = "instruction_prescriptions"
		belongs_to :instruction, class_name: "BxBlockPrescription::Instruction"
		belongs_to :prescription, class_name: "BxBlockPrescription::Prescription"
		belongs_to :medicine, class_name: "BxBlockPrescription::Medicine"
	end
end