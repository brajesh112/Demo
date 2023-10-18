module BxBlockPatient
	class Patient < ApplicationRecord
		self.table_name = "patient_tests"
		belongs_to :patient, class_name: "BxBlockPatient::Patient"
		enum :status, [:positive, :negative]
		belongs_to :report, class_name: "BxBlockPatient::Report"
	end
end
