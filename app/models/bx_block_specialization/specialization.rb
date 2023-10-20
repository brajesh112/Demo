module BxBlockSpecialization
	class Specialization < ApplicationRecord
		self.table_name = "specializations"
		has_and_belongs_to_many :accounts, class_name: "AccountBlock::Account"
		validates :specialization_name, presence: true
	end
end
