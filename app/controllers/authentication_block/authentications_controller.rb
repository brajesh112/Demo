module AuthenticationBlock
	class AuthenticationsController < ApplicationController
		skip_before_action :authenticate_request

		def login
			@account = AccountBlock::Account.find_by(email: params[:email])
			if @account&.authenticate(params[:password])
				token = jwt_encode({id: @account.id})
				render json: {token: token}, status: :ok 
			else
				render json: {error: "unauthorized"}, status: :unauthorized
			end
		end
	end
end