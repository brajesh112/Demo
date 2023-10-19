module BxBlockCoach
	class Coach < ApplicationRecord
		self.table_name = "coaches"
		belongs_to :account, class_name: "AccountBlock::Account"
		has_and_belongs_to_many :specializations, class_name: "BxBlockSpecialization::Specialization"
		validates :name, :practicing_from, :professional_statement,:start_time, :end_time, presence: true

		validate :timecheck

		def timecheck
			if self.start_time && self.end_time
			 	if self.start_time.to_time > self.end_time.to_time
			 	 errors.add(:start_time, "can't be greater than end time")
			 	end
			end
		end
	end
end