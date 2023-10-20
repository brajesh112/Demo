FactoryBot.define do
	factory :account, class: "AccountBlock::Account" do
		first_name {Faker::Name.first_name} 
		last_name {Faker::Name.last_name}
		email {Faker::Internet.unique.email(domain: 'gmail.com')}
		user_name {Faker::Internet.unique.user_name}
		password {"123456"}
		type {"AccountBlock::EmailAccount"}
		role {rand(0...3)}
		phone_number {"7896541236"}
		gender {Faker::Gender.binary_type}
		profile_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'photos', 'profile.png'), 'image/png') }
		# image = File.open(Faker::LoremFlickr.image)
	      
	  # after(:build) do |post|
	  #   post.profile_image.attach({io: File.new(Rails.root.join('spec', 'photos', 'profile.png')),
	  #     filename: 'profile.png',
	  #     content_type: 'image/png'
	  #   })
	  # end
  end
end