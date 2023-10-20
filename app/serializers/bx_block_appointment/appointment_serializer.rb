module BxBlockAppointment
	class AppointmentSerializer
	  include FastJsonapi::ObjectSerializer
	  attribute :healthcareable_type, :account_id, :patient_id, :slot_id,
	  :date
	  # attribute "healthcareable_id" do |object|
	  # 	BxBlockDoctor::Doctor.find_by(id: object.healthcareable_id).name
	  # end
	end
end
