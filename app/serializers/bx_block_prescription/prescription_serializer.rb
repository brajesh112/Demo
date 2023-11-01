class BxBlockPrescription::PrescriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :duration, :quantity, :patient_id, :instruction_prescriptions
  belongs_to :account
end
