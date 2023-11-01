FactoryBot.define do
  factory :conversation, class: 'BxBlockConversation::Conversation' do
    conversation_id { "MyString" }
    association :account, factory: [:account, :doctor]
    association :patient, factory: [:account, :patient]
  end
end
