module BxBlockSession
	class PatientCoachSession < ApplicationRecord
		self.table_name = "patient_coach_sessions"
		belongs_to :account, class_name: "AccountBlock::Account"
		belongs_to :patient, class_name: "AccountBlock::Account"
		belongs_to :coach_session, class_name: "BxBlockSession::CoachSession"
		belongs_to :session, class_name: "BxBlockSession::Session"
		enum :payment_status, [:paid, :pending]
	end
end
