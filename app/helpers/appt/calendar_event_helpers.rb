module Appt
  module CalendarEventHelpers
    def calendar_event_calendar(timezone, calendar_events, options = {}, &block)
      calendar = BootstrapMonthCalendar.new(self, options.merge(timezone: timezone, events: calendar_events))

      calendar_render = proc do |date, events|
        concat content_tag :h3, date.day
        concat capture(date, events, &block)
      end

      calendar.render(calendar_render)
    end
  end
end

