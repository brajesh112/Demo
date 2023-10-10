module AccountBlock
	class AccountSerializer
		include FastJsonapi::ObjectSerializer
	  attributes :id, :user_name, :first_name, :last_name, :email,:gender, :role
	  attribute "profile image" do |object|
	  	object.profile_image.url
	  end
	end
end
