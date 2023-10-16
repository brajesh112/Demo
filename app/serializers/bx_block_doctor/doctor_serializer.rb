module BxBlockDoctor
	class DoctorSerializer
	  include FastJsonapi::ObjectSerializer
	  attributes :name, :practicing_from, :professional_statement, :department_id, :account_id
	  belongs_to :account
	end
end
