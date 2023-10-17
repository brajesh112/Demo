module BxBlockDepartment
	class Department < ApplicationRecord
		self.table_name = "departments"
		has_many :doctors, class_name: "BxBlockDoctor::Doctor"
		validates :name, presence: true
	end
end
