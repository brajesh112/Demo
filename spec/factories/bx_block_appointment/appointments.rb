FactoryBot.define do
  factory :appointment, class: 'BxBlockAppointment::Appointment' do
    
  	date {DateTime.now}
  	status {rand(0..4)}
    association :slot, factory: :slot
    association :patient, factory: :patient_account
  end
end
