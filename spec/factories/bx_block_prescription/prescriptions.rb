FactoryBot.define do
  factory :prescription, class: 'BxBlockPrescription::Prescription' do
    quantity {2}
    duration {"3 days"}
    association :patient, factory: [:account, :patient]
    association :account, factory: [:account, :doctor]
  end
end
