class TwilioClient
	class << self
	  @@client = Twilio::REST::Client.new
		def create_conversation
			conversation = @@client.conversations.v1.conversations.create(friendly_name: 'Friendly Conversation')
			conversation.sid
	 end

		def add_participant(c_id, patient, doctor)
			participant1 = @@client.conversations.v1.conversations("#{c_id}").participants.create(identity: "#{patient.id}", attributes: {role: "patient", user_name: "#{patient.user_name}"}.to_json)

			participant2 = @@client.conversations.v1.conversations("#{c_id}").participants.create(identity: "#{doctor.id}", attributes: {role: "doctor", user_name: "#{doctor.user_name}"}.to_json)
	 	end

	 	def message (c_id, user, body)
	 		message = @@client.conversations.v1.conversations("#{c_id}").messages.create(author: "#{user}", body: "#{body}")
	 	end
	end
end
