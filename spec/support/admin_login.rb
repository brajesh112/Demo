module AdminLogin
	def set_admin_user
		before do
  		@adminuser = create(:admin_user)
    	sign_in @adminuser
  	end
	end
end