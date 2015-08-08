module Appt
  class Appointment < CalendarEvent
    belongs_to :calendar, inverse_of: :appointments
  end
end

