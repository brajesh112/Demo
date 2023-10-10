class ApplicationController < ActionController::Base
	 protect_from_forgery 
	include JwtToken

	before_action :authenticate_request

	private
		def authenticate_request
			header = request.headers["Authorization"]
			header = header.split(' ').last if header
			decoded = jwt_decode(header)
			@current_account = AccountBlock::Account.find_by(id: decoded[:id])
		end
end
