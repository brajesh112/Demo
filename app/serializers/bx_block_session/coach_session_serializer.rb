module BxBlockSession
	class CoachSessionSerializer
		include FastJsonapi::ObjectSerializer
		attributes :notes, :start_time, :end_time, :entery_fee, :fees, :status, :type
		has_one :account
	end
end