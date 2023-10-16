module BxBlockPatient
	class Patient < ApplicationRecord
		self.table_name = "patients"
		belongs_to :account, class_name: "AccountBlock::Account", optional: true
		validates :first_name, :last_name, :gender, :phone_number, :email, :age, :address, presence: true
	end
end