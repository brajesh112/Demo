class ApplicationController < ActionController::Base
	 include ActiveStorage::SetCurrent
	 protect_from_forgery 
	include JwtToken

	before_action :authenticate_request

	private
		def authenticate_request
			header = request.headers["token"]
			token = header.split(' ').last if header
			begin
				decoded = jwt_decode(token)
				@current_account = AccountBlock::Account.find_by(id: decoded[:id])
			rescue =>error
				return render json: {error: error}, status: :unprocessable_entity
			end
		end
end
