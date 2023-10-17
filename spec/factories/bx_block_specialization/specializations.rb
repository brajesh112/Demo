FactoryBot.define do
  factory :bx_block_specialization_specialization, class: 'BxBlockSpecialization::Specialization' do
    specialization_name {Faker::Name.name}
  end
end
