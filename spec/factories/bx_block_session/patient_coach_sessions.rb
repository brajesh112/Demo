FactoryBot.define do
  factory :patient_coach_session, class: 'BxBlockSession::PatientCoachSession' do
    date {DateTime.now}
    association :session, factory: :session
    association :account, factory:[:account,  :coach]
    association :coach_session, factory: :coach_session
    payment_status {rand(0..1)} 
    association :patient, factory: [:account, :patient] 
  end
end