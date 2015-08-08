module Appt
  class Block < CalendarEvent
    belongs_to :external_calendar

    # Note: delete_all is called on this for sync'ing
  end
end

