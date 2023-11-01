FactoryBot.define do
  factory :coach_session, class: 'BxBlockSession::CoachSession' do
    notes {"This is for testing purpose only"} 
    start_time {"10:00"}
    end_time {"15:00"}
    entery_fee {rand(1..100)} 
    fees {rand(1..100)}
    status {rand(0..1)}
    type {"BxBlockSession::PublicSession"}
    association :account, factory: [:account, :coach]
  end
end
