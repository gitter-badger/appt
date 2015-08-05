class CreateApptAppointmentTypes < ActiveRecord::Migration
  def change
    create_table :appt_appointment_types do |t|
      t.string :name, null: false
      t.integer :duration_minutes
      t.integer :before_minutes
      t.integer :after_minutes

      t.timestamps null: false
    end
  end
end

