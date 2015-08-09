module Appt
  class AppointmentType < ActiveRecord::Base
    has_many :appointments, dependent: :destroy
    has_and_belongs_to_many :calendars, join_table: :appt_calendars_appointment_types

    validates :duration_minutes, :before_minutes, :after_minutes,
      presence: true, numericality: { greater_than_or_equal_to: 0 }
  end
end

