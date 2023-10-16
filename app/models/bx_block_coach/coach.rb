module BxBlockCoach
	class Coach < ApplicationRecord
		self.table_name = "coaches"
		belongs_to :account, class_name: "AccountBlock::Account"
		validates :name, :practicing_from, :professional_statement, presence: true
	end
end