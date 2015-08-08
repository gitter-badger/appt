module Appt
  class IcalendarExpander
    attr_reader :timezone, :calendars, :include_transparent
    alias_method :include_transparent?, :include_transparent

    def initialize(timezone, calendars, options = {})
      @timezone = timezone
      @calendars = calendars
      @include_transparent = options.delete(:include_transparent) || false
    end

    def events(min_date, max_date, &block)
      return enum_for(:events, min_date, max_date) unless block_given?

      @calendars.each do |cal|
        cal.events.each do |event|
          event.occurrences_between(min_date, max_date).each do |occurrence|
            normalize_event(event, occurrence, min_date, max_date, &block)
          end
        end
      end
    end

  protected

    def all_day?(event)
      event.dtstart.is_a?(Icalendar::Values::Date) &&
        event.dtend.is_a?(Icalendar::Values::Date)
    end

    def normalize_datetime(datetime, all_day)
      if all_day
        datetime.to_date
      else
        datetime.in_time_zone(@timezone).to_datetime
      end
    end

    def normalize_event(event, occurrence, min_date, max_date, &block)
      return if event.transp == 'TRANSPARENT' && !@include_transparent

      all_day = all_day?(event)

      s = normalize_datetime(occurrence.start_time, all_day)
      e = normalize_datetime(occurrence.end_time, all_day)

      days = (s..e).map(&:to_date).select{ |d| d >= min_date && d < max_date }

      days.each_with_index do |day, i|
        block.call(
          name: event.summary.to_s,
          day: day,
          start: i == 0 ? s.to_time_of_day : Tod::TimeOfDay.parse('midnight'),
          end: i == days.size - 1 ? e.to_time_of_day : Tod::TimeOfDay.parse('midnight'),
          external_id: event.uid.to_s,
        )
      end
    end
  end
end

