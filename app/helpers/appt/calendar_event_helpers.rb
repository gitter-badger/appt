module Appt
  module CalendarEventHelpers
    def calendar_event_calendar(timezone, calendar_events = nil, options = {}, &block)
      calendar_events, options = nil, calendar_events if calendar_events.is_a?(Hash)

      options.merge!(timezone: timezone)
      options.merge!(events: calendar_events) if calendar_events

      calendar = BootstrapMonthCalendar.new(self, options)

      calendar_render = proc do |date, events|
        concat capture(date, events, &block)
      end

      calendar.render(calendar_render)
    end
  end
end

