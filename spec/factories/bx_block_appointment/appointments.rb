FactoryBot.define do
  factory :appointment, class: 'BxBlockAppointment::Appointment' do
    
  	date {DateTime.now}
    association :slot, factory: :slot
    # association :patient, factory: :patient
    # association :healthcareable, factory: :doctor
    
    # trait :coach do
    # 	association :healthcareable, factory: :coach
    # end
  end
end
