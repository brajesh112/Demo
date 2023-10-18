module BxBlockPrescription
	class Medicine < ApplicationRecord
		self.table_name = "medicines"
    belongs_to :prescription, class_name:"BxBlockPrescription::Prescription"
	end
end
