module BxBlockSession
	class SessionSerializer
		include FastJsonapi::ObjectSerializer
		attributes :session_time
	end
end