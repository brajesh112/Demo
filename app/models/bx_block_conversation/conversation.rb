module BxBlockConversation
	class Conversation < ApplicationRecord
		self.table_name = "conversations"
		belongs_to :account, class_name: "AccountBlock::Account"
		belongs_to :patient, class_name: "AccountBlock::Account"
	end
end
