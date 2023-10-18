module BxBlockSpecialization
	class Specialization < ApplicationRecord
		self.table_name = "specializations"
		has_and_belongs_to_many :doctors, class_name: "BxBlockDoctor::Doctor"
		has_and_belongs_to_many :coaches, class_name: "BxBlockCoach::Coach"
		validates :specialization_name, presence: true
	end
end
