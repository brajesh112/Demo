module BxBlockPatient
	class Patient < ApplicationRecord
		self.table_name = "patients"
		belongs_to :account, class_name: "AccountBlock::Account", optional: true
	end
end