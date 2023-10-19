module BxBlockPrescription
	class Medicine < ApplicationRecord
		self.table_name = "medicines"
    validates :name, :description, presence: true
	end
end
