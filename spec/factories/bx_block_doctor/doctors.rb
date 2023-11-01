FactoryBot.define do
  factory :doctor, class: 'BxBlockDoctor::Doctor' do
    name {Faker::Name.name}
		practicing_from {"2008-02-20T00:00:00.000Z"}
		professional_statement {"Graduated from AIIMS Bhopal"}
    start_time {"10:00"}
    end_time {"13:00"}
    association :department, factory: :department
    association :account, factory: [:account,:doctor]
  end
end
