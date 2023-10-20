module BxBlockPatient
	class PatientTest < ApplicationRecord
		self.table_name = "patient_tests"
		belongs_to :patient, class_name: "AccountBlock::Account"
		belongs_to :account, class_name: "AccountBlock::Account"
		enum :status, [:positive, :negative]
		belongs_to :report, class_name: "BxBlockPatient::Report"
	end
end
