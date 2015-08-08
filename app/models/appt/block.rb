module Appt
  class Block < CalendarEvent
    belongs_to :external_calendar
  end
end

