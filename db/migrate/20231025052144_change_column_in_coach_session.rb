class ChangeColumnInCoachSession < ActiveRecord::Migration[7.0]
  def change
  	change_column :coach_sessions, :fees, :decimal, using: 'fees::numeric'
  	rename_column :coach_sessions, :entry_fee, :entery_fee
  	change_column :coach_sessions, :entery_fee, :decimal, using: 'entery_fee::numeric'
  end
end
