module BxBlockConversation
	class ConversationsController < ApplicationController
		before_action :authenticate_request

		def create
			account = AccountBlock::Account.find_by(id: params[:doc_id])
			return render json: {error: "account not found"}, status: :not_found unless account
			begin
				sid = TwilioClient.create_conversation 
				TwilioClient.add_participant(sid, @current_account, account)
				conversation = account.conversations.create(patient_id: @current_account.id, conversation_id: sid)
			rescue => error
				return render json: {error: error.message}, status: :unprocessable_entity
			end
			render json: BxBlockConversation::ConversationSerializer.new(conversation).serializable_hash, status: :ok
		end

		def send_message
			begin
				message = TwilioClient.message(params[:conversation_id], @current_account.user_name, params[:body])
			rescue => error
				return render json: {error: error.message}, status: :unprocessable_entity
			end
			render json: { message: message.body, author: message.author }, status: :ok	
		end

		def select_account
			accounts = AccountBlock::Account.joins(:conversations).where("conversations.patient_id" => @current_account.id).uniq
			render json: AccountBlock::AccountSerializer.new(accounts, meta: {message: "select account to continue conversation"}).serializable_hash, status: :ok
		end

		def select_new_account
			accounts = AccountBlock::Account.joins(:appointments).where("appointments.patient_id" => @current_account.id).uniq
			render json: AccountBlock::AccountSerializer.new(accounts, meta: {message: "select account for new conversation"}).serializable_hash, status: :ok
		end

		def update 
			account = AccountBlock::Account.find_by(id: params[:doc_id])
			conversation = BxBlockConversation::Conversation.find_by(account_id: account.id, patient_id: @current_account.id)
			messages = TwilioClient.continue_conversation(conversation.conversation_id) if conversation
			render json: messages.map {|message|  {message: message.body, author: message.author}}, status: :ok	
		end
	end
end