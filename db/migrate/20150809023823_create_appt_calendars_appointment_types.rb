class CreateApptCalendarsAppointmentTypes < ActiveRecord::Migration
  def change
    create_table :appt_calendars_appointment_types, id: false do |t|
      t.belongs_to :calendar, index: true
      t.belongs_to :appointment_type, index: true
    end
  end
end
