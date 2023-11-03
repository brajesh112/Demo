module AccountBlock
	class AccountsController < ApplicationController
		skip_before_action :authenticate_request, only: [:create]

		def index
			accounts = Account.all
			render json: AccountBlock::AccountSerializer.new(accounts).serializable_hash, status: :ok
		end

		def show
			render json: AccountBlock::AccountSerializer.new(@current_account).serializable_hash, status: :ok 
		end

		def create
			case params[:type]
				when "email"
					account = EmailAccount.new(account_params)
				when "sms"
					account = SmsAccount.new(account_params)
				else
					account = EmailAccount.new(account_params)
			end

			if account.save
				render json: AccountBlock::AccountSerializer.new(account, meta: {message: "Account created Successfully"}).serializable_hash, status: :created
			else
				render json: {errors: account.errors.full_messages }, status: :unprocessable_entity
			end
		end

		def update
			unless @current_account.update(account_params)
				render json: {errors: @current_account.errors.full_messages }, status: :unprocessable_entity
			else
				render json: AccountBlock::AccountSerializer.new(@current_account, meta: {message: "Updated Successfully"}).serializable_hash, status: :ok 
			end
		end

		def destroy
			@current_account.destroy
			render json: AccountBlock::AccountSerializer.new(@current_account,meta: {message: "Account Deleted Successfully"}).serializable_hash,status: :ok if @current_account
		end

		def specialization
			specializations = BxBlockSpecialization::Specialization.where(id: params[:ids])
			@current_account.specializations << specializations if @current_account.role != ('patient')
			render json: AccountBlock::AccountSerializer.new(@current_account,meta: {message: "Updated Specialization"}).serializable_hash,status: :ok 
		end

		private 
			def account_params
				params.permit(:user_name, :first_name, :last_name, :email, :password, :gender, :role, :phone_number, :profile_image)
			end
	end
end
