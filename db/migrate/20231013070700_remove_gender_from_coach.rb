class RemoveGenderFromCoach < ActiveRecord::Migration[7.0]
  def change
  	remove_column :coaches, :gender, :string
  	remove_column :coaches, :phone_number, :bigint
  end
end
