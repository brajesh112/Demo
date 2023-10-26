FactoryBot.define do
  factory :conversation, class: 'BxBlockConversation::Conversation' do
    conversation_id { "MyString" }
    association :account, factory: :doctor_account
    association :patient, factory: :patient_account
  end
end
