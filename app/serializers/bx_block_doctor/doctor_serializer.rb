module BxBlockDoctor
	class DoctorSerializer
	  include FastJsonapi::ObjectSerializer
	  attributes :name, :practicing_from, :professional_statement, :department_id, :account_id, :start_time, :end_time
	  belongs_to :account
	end
end
