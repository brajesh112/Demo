FactoryBot.define do
  factory :bx_block_coach_coach, class: 'BxBlockCoach::Coach' do
    name {Faker::Name.name}
    practicing_from {"2008-02-20T00:00:00.000Z"}

		professional_statement {"Bhopal"}

    trait :account do
    	association :account, factory: "AccountBlock::Account"
    end
    
  end
end
