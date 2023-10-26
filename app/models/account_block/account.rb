module AccountBlock
	class Account < ApplicationRecord
		self.table_name = "accounts"
		has_secure_password
		validates :user_name, :email, uniqueness: true
		validates :first_name, :last_name, :user_name, :email, :gender, :password, :role, :type, :phone_number, presence: true
		enum :role, [:patient, :coach, :doctor, :staff]
		has_one_attached :profile_image, dependent: :destroy
		has_one :patient, dependent: :destroy, class_name: "BxBlockPatient::Patient"
		has_one :doctor, dependent: :destroy,class_name: "BxBlockDoctor::Doctor"
		has_one :coach, dependent: :destroy,class_name: "BxBlockCoach::Coach"
		has_many :appointments, class_name: "BxBlockAppointment::Appointment"
		has_many :other_appointments, class_name: "BxBlockAppointment::Appointment", foreign_key: "patient_id"
		has_many :patient_tests, class_name: "BxBlockPatient::PatientTest"
		has_many :other_patient_tests, class_name: "BxBlockPatient::PatientTest", foreign_key: "patient_id"
		has_many :patient_triages, class_name: "BxBlockPatient::PatientTriage", foreign_key: "patient_id"
		has_and_belongs_to_many :specializations, class_name: "BxBlockSpecialization::Specialization"
		has_many :prescriptions, class_name: "BxBlockPrescription::Priscription"
		has_many :other_prescriptions, class_name: "BxBlockPrescription::Priscription", foreign_key: "patient_id"
		has_many :coach_sessions, class_name: "BxBlockSession::CoachSession"
		has_many :conversations, class_name: "BxBlockConversation::Conversation"
		has_many :other_conversations, class_name: "BxBlockConversation::Conversation", foreign_key: :patient_id
		# has_many :other_patient_coach_sessions, class_name: "BxBlockSession::PatientCoachSession", foreign_key: :patient_id
		has_many :patient_coach_sessions, class_name: "BxBlockSession::PatientCoachSession", foreign_key: :patient_id
		has_many :other_coach_sessions, through: :patient_coach_sessions,class_name: "BxBlockSession::CoachSession", source: :coach_session
	end
end