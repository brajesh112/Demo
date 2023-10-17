module BxBlockSpecialization
	class Specialization < ApplicationRecord
		self.table_name = "specializations"
		has_and_belongs_to_many :doctors, class_name: "BxBlockDoctor::Doctor"
		validates :specialization_name, presence: true
	end
end
