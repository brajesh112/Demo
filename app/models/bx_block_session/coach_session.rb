module BxBlockSession
	class CoachSession < ApplicationRecord
		self.table_name = "coach_sessions"
		belongs_to :account, class_name: "AccountBlock::Account"
		has_many :patient_coach_session, dependent: :destroy, class_name: "BxBlockSession::PatientCoachSession"
		has_many :patients, through: :patient_coach_session, class_name: "AccountBlock::Account", foreign_key: :patient_id, dependent: :destroy
		enum :status, [:available, :unavailable]
	end
end
