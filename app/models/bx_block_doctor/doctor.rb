module BxBlockDoctor
	class Doctor < ApplicationRecord
		self.table_name = "doctors"
		belongs_to :account, class_name: "AccountBlock::Account"
		belongs_to :department, class_name: "BxBlockDepartment::Department"
		validates :name, :practicing_from, :professional_statement, :start_time, :end_time, presence: true
		validate :timecheck
		enum :status, [:active, :inactive]

		def timecheck
			if self.start_time && self.end_time
			 	if self.start_time.to_time > self.end_time.to_time
			 	 errors.add(:start_time, "can't be greater than end time")
			 	end
			end
		end
	end
end