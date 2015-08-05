class CreateApptExternalCalendars < ActiveRecord::Migration
  def change
    create_table :appt_external_calendars do |t|
      t.string :url
      t.string :name

      t.timestamps null: false
    end
  end
end
