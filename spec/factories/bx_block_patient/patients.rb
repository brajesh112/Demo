FactoryBot.define do
  factory :patient, class: 'BxBlockPatient::Patient' do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.unique.email(domain: 'gmail.com')}
    age {rand(1..100)}
    phone_number {Faker::PhoneNumber.phone_number}
    gender {Faker::Gender.binary_type}
    address {Faker::Address.full_address}
    association :account, factory: :patient_account
  end
end
