module AccountBlock
	class AccountsController < ApplicationController
		protect_from_forgery
		skip_before_action :authenticate_request, only: [:create]

		def index
			@accounts = Account.all
			render json: @accounts, status: :ok
		end

		def show
			render json: AccountBlock::AccountSerializer.new(@current_account, meta: {message: "Show Action"}).serializable_hash, status: :ok if @current_account
		end

		def create
			debugger
			if params[:type].eql?("email")
				@account = EmailAccount.new(account_params)
			else
				@account = SmsAccount.new(account_params)
			end
			# @account = Account.new(account_params)
			if @account.save
				render json: @account, status: :created
			else
				debugger
				render json: {errors: @account.errors.full_messages }, status: :unprocessable_entity
			end
		end

		def update
			unless @current_account.update(account_params)
				render json: {errors: @current_account.errors.full_messages }, status: :unprocessable_entity
			else
				render json: AccountBlock::AccountSerializer.new(@current_account, meta: {message: "Updated Successfully"}).serializable_hash, status: :ok if @current_account
			end
		end

		def destroy
			@current_account.destroy
			render json: @current_account
		end

		private 
			def account_params
				params.permit(:user_name, :first_name, :last_name, :email, :password, :gender, :role, :profile_image)
			end
	end
end
