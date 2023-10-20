module BxBlockPatient
	class Report < ApplicationRecord
		self.table_name = "reports"
		has_many :patient_tests, class_name: "BxBlockPatient::PatientTest"
		belongs_to :patient, class_name: "AccountBlock::Account"
	end
end
