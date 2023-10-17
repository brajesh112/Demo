FactoryBot.define do
  factory :admin_user do
    email {Faker::Internet.unique.email(domain: 'gmail.com')}
    password {"123456"}
  end
end
