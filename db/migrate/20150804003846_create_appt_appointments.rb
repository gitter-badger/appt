class CreateApptAppointments < ActiveRecord::Migration
  def change
    create_table :appt_appointments do |t|
      t.integer :calendar_id
      t.date :day, null: false
      t.string :start, null: false
      t.string :end, null: false
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :phone

      t.timestamps null: false
    end
  end
end

