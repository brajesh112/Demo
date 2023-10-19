FactoryBot.define do
  factory :coach, class: 'BxBlockCoach::Coach' do
    name {Faker::Name.name}
    practicing_from {"2008-02-20T00:00:00.000Z"}

		professional_statement {"Bhopal"}
		start_time {"10:00"}
    end_time {"13:00"}
    association :account, factory: :coach_account   
  end
end
