class CreateBxBlockCoachCoachSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :coach_sessions do |t|
    	t.references :account
    	t.date :date
    	t.text :notes
    	t.string :type
      t.timestamps
    end
  end
end
