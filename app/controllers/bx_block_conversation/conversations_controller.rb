module BxBlockConversation
	class ConversationsController < ApplicationController
		before_action :authenticate_request

		def create
			#comment: need to remove where condition and add find_by
			account = AccountBlock::Account.find_by(id: params[:doc_id])
			conversation = BxBlockConversation::Conversation.where(account_id: account.id, patient_id: @current_account.id)
			unless conversation.present?
				begin
					sid = TwilioClient.create_conversation 
					TwilioClient.add_participant(sid, @current_account, account)
					conversation = account.conversations.create(patient_id: @current_account.id, conversation_id: sid)
				rescue => error
					return render json: {error: error.message}, status: :unprocessable_entity
				end
			end
			render json: BxBlockConversation::ConversationSerializer.new(conversation).serializable_hash, status: :ok
		end

		def send_message
			#comment: pass parameter directly in the method 
			body = params[:body]
			user = @current_account.user_name
			c_id = params[:conversation_id]
			begin
				message = TwilioClient.message(c_id, user, body)
			rescue => error
				return render json: {error: error.message}, status: :unprocessable_entity
			end
			render json: {message: message}, status: :ok
		end


		def select_doctor
			accounts = AccountBlock::Account.joins(:appointments).where("appointments.patient_id" => @current_account.id).uniq
			render json: AccountBlock::AccountSerializer.new(accounts, meta: {message: "select doctor for conversation"}).serializable_hash, status: :ok
		end

	end
end