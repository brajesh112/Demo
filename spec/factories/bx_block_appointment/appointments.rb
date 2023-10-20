FactoryBot.define do
  factory :appointment, class: 'BxBlockAppointment::Appointment' do
    
  	date {DateTime.now}
    association :slot, factory: :slot
  end
end
