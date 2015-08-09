module Appt
  class Block < CalendarEvent
    belongs_to :calendar, inverse_of: :blocks
    belongs_to :external_calendar

    # Note: delete_all is called on this for sync'ing

    def title
      [
        name,
        'Block',
      ].find{ |s| !s.blank? }
    end
  end
end

