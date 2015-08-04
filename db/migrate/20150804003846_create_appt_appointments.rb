class CreateApptAppointments < ActiveRecord::Migration
  def change
    create_table :appt_appointments do |t|

      t.timestamps null: false
    end
  end
end
