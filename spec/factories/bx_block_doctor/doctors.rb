FactoryBot.define do
  factory :bx_block_doctor_doctor, class: 'BxBlockDoctor::Doctor' do
    name {Faker::Name.name}
		practicing_from {"2008-02-20T00:00:00.000Z"}
		professional_statement {"Graduated from AIIMS Bhopal"}

		trait :department do
    	association :department, factory: :bx_block_department_department
    end

    trait :account do
    	association :account, factory: "AccountBlock::Account"
    end

  end
end
