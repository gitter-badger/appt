class AddAppointmentTypeToAppointments < ActiveRecord::Migration
  def change
    add_column :appt_appointments, :appointment_type_id, :integer
  end
end
