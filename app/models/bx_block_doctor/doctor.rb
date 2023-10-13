module BxBlockDoctor
	class Doctor < ApplicationRecord
		self.table_name = "doctors"
		belongs_to :account, class_name: "AccountBlock::Account"
		belongs_to :department, class_name: "BxBlockDepartment::Department"
		has_and_belongs_to_many :specializations, class_name: "BxBlockSpecialization::Specialization"
		validates :name, :practicing_from, :professional_statement, presence: true

	end
end