module BxBlockSession
	class CoachSessionSerializer
		include FastJsonapi::ObjectSerializer
		attributes :notes, :account_id, :start_time, :end_time, :entry_fee, :fees, :status
		has_many :accounts
	end
end