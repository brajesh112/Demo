module BxBlockPatient
	class Patient < ApplicationRecord
		self.table_name = "patients"
		belongs_to :account, class_name: "AccountBlock::Account", optional: true
		has_one :patient_triage, class_name: "BxBlockPatient::PatientTriage"
		has_many :patient_tests, class_name: "BxBlockPatient::PatientTest"
		has_many :appointments, class_name: "BxBlockAppointment::Appointment"
		validates :first_name, :last_name, :gender, :phone_number, :email, :age, :address, presence: true
		has_many :prescriptions, class_name: "BxBlockPrescription::Prescription"
	end
end