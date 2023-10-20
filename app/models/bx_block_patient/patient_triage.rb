module BxBlockPatient
	class PatientTriage < ApplicationRecord
		self.table_name = "patient_triages"
		belongs_to :patient, class_name: "AccountBlock::Account"
	end
end