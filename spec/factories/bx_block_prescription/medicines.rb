FactoryBot.define do
  factory :medicine, class: 'BxBlockPrescription::Medicine' do
    name {Faker::Name.name}
    description {Faker::String.random}
  end
end
