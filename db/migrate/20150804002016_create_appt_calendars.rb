class CreateApptCalendars < ActiveRecord::Migration
  def change
    create_table :appt_calendars do |t|
      t.string :name
      t.text :availability
      t.string :timezone_name
      t.integer :resolution_minutes
      t.integer :min_hours
      t.integer :max_days
      t.integer :lock_hours

      t.timestamps null: false
    end
  end
end

