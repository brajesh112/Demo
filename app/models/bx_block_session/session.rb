module BxBlockSession
	class Session < ApplicationRecord
		self.table_name = "sessions"
		has_many :patient_coach_sessions, class_name: "BxBlockSession::PatientCoachSession"
	end
end
