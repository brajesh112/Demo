require 'faker'
FactoryBot.define do
  
  factory "AccountBlock::Account" do
		first_name {Faker::Name.first_name} 
		last_name {Faker::Name.last_name}
		email {Faker::Internet.unique.email(domain: 'gmail.com')}
		user_name {Faker::Internet.unique.user_name}
		password {"123456"}
		type {"AccountBlock::EmailAccount"}
		role {"doctor"}
		gender {Faker::Gender.binary_type}
  end
end