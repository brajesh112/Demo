module BxBlockSession
	class PatientCoachSessionSerializer
		include FastJsonapi::ObjectSerializer
		attributes :coach_session_id, :date, :session_id, :payment_status
		has_one :account
		has_one :patient
	end
end