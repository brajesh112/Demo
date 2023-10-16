class BxBlockPatient::PatientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :age, :gender, :age, :phone_number, :email, :account_id
end
