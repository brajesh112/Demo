FactoryBot.define do
  factory :medicine, class: 'BxBlockPrescription::Medicine' do
    name {Faker::Name.name}
    description {"description of test medicine"}
  end
end
