module Appt
  class Scheduler
    attr_accessor :week, :resolution, :duration, :before, :after

    def initialize(week, options = {})
      @week = week
      @resolution = options.delete(:resolution) || 30.minutes
      @duration = options.delete(:duration) || 30.minutes
      @before = options.delete(:before) || 0.minutes
      @after = options.delete(:after) || 0.minutes
    end

    def raw_shifts(day, &block)
      return enum_for(:raw_shifts, day) unless block_given?

      week.hours_on(day).each do |period|
        start = period.beginning.to_i
        start = ((start / resolution) + 1) * resolution if start % resolution != 0
        start += duration * (before.to_f / duration).ceil if before > 0
        start = Tod::TimeOfDay.from_i(start)

        candidate = Tod::Shift.new(start - before, start + duration + after, true)

        while period.shift.contains?(candidate)
          block.call(candidate)

          candidate = candidate.slide(duration)
        end
      end
    end

    def display_shift(shift)
      Tod::Shift.new(shift.beginning + before, shift.ending - after, true)
    end

    def shifts(day, &block)
      return enum_for(:shifts, day) unless block_given?

      raw_shifts(day) do |shift|
        block.call(display_shift(shift))
      end
    end

    def available_shifts(day, conflicts = [], &block)
      return enum_for(:available_shifts, day, conflicts) unless block_given?

      raw_shifts(day).reject{ |s| conflicts.any?{ |c| c.overlaps?(s) } }.each do |shift|
        block.call(display_shift(shift))
      end
    end

    # def next_available(start, end, blocks=[])
  end
end

