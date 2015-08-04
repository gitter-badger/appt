class CreateApptCalendars < ActiveRecord::Migration
  def change
    create_table :appt_calendars do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
