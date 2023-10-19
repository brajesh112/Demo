FactoryBot.define do
  factory :specialization, class: 'BxBlockSpecialization::Specialization' do
    specialization_name {Faker::Name.name}
  end
end
