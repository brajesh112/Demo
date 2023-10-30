class ApplicationController < ActionController::Base
	 include ActiveStorage::SetCurrent
	 protect_from_forgery 
	include JwtToken

	before_action :authenticate_request

	private
		def authenticate_request
			header = request.headers["Authorization"]
			token = header.split(' ').last if header
			decoded = jwt_decode(token) if token
			@current_account = AccountBlock::Account.find_by(id: decoded[:id]) if decoded
		end
end
