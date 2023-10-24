module BxBlockCoach
	class CoachSerializer
	  include FastJsonapi::ObjectSerializer
	  attributes :name, :practicing_from, :professional_statement, :account_id
		  belongs_to :account
	end
end
