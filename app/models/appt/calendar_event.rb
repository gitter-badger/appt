module Appt
  class CalendarEvent < ActiveRecord::Base
    extend SimpleCalendar

    self.abstract_class = true

    has_calendar attribute: :day

    serialize :start, Tod::TimeOfDay
    serialize :end, Tod::TimeOfDay

    # assumes belongs_to :calendar
    validates :calendar, :day, :start, :end, presence: true

    def start_local
      calendar.local_time_of_day(day, start)
    end

    def end_local
      calendar.local_time_of_day(day, self.end)
    end

    def duration
      shift.duration / 60
    end

    def duration=(value)
      fail 'Cannot assign duration if start is nil' if start.nil?

      self.end = start + value.minutes
    end

    def shift
      Tod::Shift.new(start, self.end, true)
    end
    alias_method :full_shift, :shift

    class << self
      def shifts
        all.map(&:shift)
      end

      def full_shifts
        all.map(&:full_shift)
      end
    end
  end
end

