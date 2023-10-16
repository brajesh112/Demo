FactoryBot.define do
  factory :bx_block_department_department, class: 'BxBlockDepartment::Department' do
    name {Faker::Name.name}
  end
end
