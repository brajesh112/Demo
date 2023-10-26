module BxBlockConversation
	class ConversationSerializer
		include FastJsonapi::ObjectSerializer
		attributes :conversation_id
		belongs_to :account
		belongs_to :patient
	end
end