module BxBlockPrescription
	class Prescription < ApplicationRecord
		self.table_name = "prescriptions"
		has_many :medicines, class_name: "BxBlockPrescription::Medicine"
		belongs_to :patient, class_name: "BxBlockPatient::Patient"
	end
end
