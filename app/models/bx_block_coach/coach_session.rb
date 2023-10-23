module BxBlockCoach
	class CoachSession < ApplicationRecord
		self.table_name = "coach_sessions"
		belongs_to :account, class_name: "AccountBlock::Account"
		has_and_belongs_to_many :patients, class_name: "AccountBlock::Account", foreign_key: :patient_id
	end
end
