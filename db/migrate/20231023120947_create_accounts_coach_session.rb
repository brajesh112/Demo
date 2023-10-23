class CreateAccountsCoachSession < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts_coach_sessions do |t|
    	t.references :patient, foreign_key: {to_table: "accounts"}
    	t.references :coach_session
      t.timestamps
    end
  end
end
