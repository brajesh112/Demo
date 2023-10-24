class CreateBxBlockSessionCoachSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :coach_sessions do |t|
    	t.references :account
    	t.string :type
    	t.string :start_time
    	t.string :end_time
    	t.string :entry_fee
    	t.string :fees
    	t.integer :status
    	t.text :notes
      t.timestamps
    end
  end
end
