module BxBlockConversation
	class ConversationsController < ApplicationController
		before_action :authenticate_request

		def create
			account = AccountBlock::Account.find_by(id: params[:doc_id])
			conversation = BxBlockConversation::Conversation.where(account_id: account.id, patient_id: @current_account.id)
			unless conversation.present?
				begin
					sid = TwilioClient.create_conversation 
					TwilioClient.add_participant(sid, @current_account, account)
					conversation = account.conversations.create(patient_id: @current_account.id, conversation_id: sid)
				rescue => error
					render json: {error: error.message}
				end
			end
			render json: BxBlockConversation::ConversationSerializer.new(conversation).serializable_hash, status: :ok
		end

		def send_message
			body = params[:body]
			user = @current_account.user_name
			c_id = params[:conversation_id]
			begin
				message = TwilioClient.message(c_id, user, body)
			rescue => error
				render json: {error: error.message}
			end
			render json: message.body
		end


		def select_doc
			accounts = AccountBlock::Account.joins(:appointments).where("appointments.patient_id" => @current_account.id).uniq
			render json: AccountBlock::AccountSerializer.new(accounts, meta: {message: "select doc for conversation"}).serializable_hash, status: :ok
		end

	end
end