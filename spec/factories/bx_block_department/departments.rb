FactoryBot.define do
  factory :department, class: 'BxBlockDepartment::Department' do
    name {Faker::Name.name}
  end
end
