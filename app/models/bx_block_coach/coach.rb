module BxBlockCoach
	class Coach < ApplicationRecord
		self.table_name = "coaches"
		belongs_to :account, class_name: "AccountBlock::Account"
		has_and_belongs_to_many :specializations, class_name: "BxBlockSpecialization::Specialization"
		validates :name, :practicing_from, :professional_statement, presence: true
		has_many :appointments, as: :healthcareable
	end
end