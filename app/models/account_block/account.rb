module AccountBlock
	class Account < ApplicationRecord
		self.table_name = "accounts"
		has_secure_password
		validates :user_name, :email, uniqueness: true
		validates :first_name, :last_name, :user_name, :email, :gender, :password, :role, :type, presence: true
		enum :role, [:patient, :coach, :doctor, :staff]
		has_one_attached :profile_image, dependent: :destroy
	end
end