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
		has_many :appointments, dependent: :destroy, class_name: "BxBlockAppointment::Appointment"
		has_many :other_appointments,dependent: :destroy, class_name: "BxBlockAppointment::Appointment", foreign_key: "patient_id"
		has_many :patient_tests, dependent: :destroy, class_name: "BxBlockPatient::PatientTest"
		has_many :other_patient_tests, dependent: :destroy,class_name: "BxBlockPatient::PatientTest", foreign_key: "patient_id"
		has_many :patient_triages, dependent: :destroy,class_name: "BxBlockPatient::PatientTriage", foreign_key: "patient_id"
		has_and_belongs_to_many :specializations, dependent: :destroy,class_name: "BxBlockSpecialization::Specialization"
		has_many :prescriptions, dependent: :destroy,class_name: "BxBlockPrescription::Prescription"
		has_many :other_prescriptions, dependent: :destroy,class_name: "BxBlockPrescription::Prescription", foreign_key: "patient_id"
		has_many :coach_sessions, dependent: :destroy,class_name: "BxBlockSession::CoachSession"
		has_many :conversations, dependent: :destroy,class_name: "BxBlockConversation::Conversation"
		has_many :other_conversations, dependent: :destroy,class_name: "BxBlockConversation::Conversation", foreign_key: :patient_id
		has_many :patient_coach_sessions, dependent: :destroy,class_name: "BxBlockSession::PatientCoachSession", foreign_key: :patient_id
		has_many :other_coach_sessions, through: :patient_coach_sessions,class_name: "BxBlockSession::CoachSession", source: :coach_session,dependent: :destroy
	end
end