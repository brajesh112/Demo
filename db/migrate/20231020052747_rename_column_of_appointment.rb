class RenameColumnOfAppointment < ActiveRecord::Migration[7.0]
  def change
  	rename_column :appointments, :healtcareable_type, :healthcareable_type
  end
end
