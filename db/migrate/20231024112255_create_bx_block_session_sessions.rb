class CreateBxBlockSessionSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
    	t.string :session_time
      t.timestamps
    end
  end
end
