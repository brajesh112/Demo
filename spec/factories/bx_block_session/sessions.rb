FactoryBot.define do
  factory :session, class: 'BxBlockSession::Session' do
    session_time {"10:00"}
  end
end
