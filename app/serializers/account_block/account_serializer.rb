module AccountBlock
	class AccountSerializer
		include FastJsonapi::ObjectSerializer
	  attributes :id, :user_name, :first_name, :last_name, :email,:gender, :role, :phone_number
	  attribute "profile image" do |object|
	  	object.profile_image.url if object.profile_image.attached?
	  	# Rails.application.routes.url_helpers.rails_blob_path(object.profile_image, only_path: true) if object.profile_image.attached?
	  	# url_for(object.profile_image) if object.profile_image.attached?
	  end
	end
end
