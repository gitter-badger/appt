module Appt
  class Scheduler
    attr_accessor :week, :resolution, :duration, :before, :after, :overlap

    def initialize(week, options = {})
      @week = week
      @resolution = options.delete(:resolution) || 30.minutes
      @duration = options.delete(:duration) || 30.minutes
      @before = options.delete(:before) || 0.minutes
      @after = options.delete(:after) || 0.minutes
      @overlap = options.delete(:overlap) || 1
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

    def available_shifts(day, conflict_shifts = [], overlap_shifts = [], &block)
      return enum_for(:available_shifts, day, conflict_shifts, overlap_shifts) unless block_given?

      raw_shifts(day)
        .reject{ |s| conflicts?(s, conflict_shifts) }
        .reject{ |s| exceeds_overlap?(s, overlap_shifts) }
        .each{ |s| block.call(display_shift(s)) }
    end

  # def next_available(start, end, blocks=[])

  private

    def conflicts?(shift, conflict_shifts)
      conflict_shifts.any?{ |c| c.overlaps?(shift) }
    end

    def exceeds_overlap?(shift, overlap_shifts)
      if overlap == 1
        conflicts?(shift, overlap_shifts)
      else
        overlap_shifts = overlap_shifts.select{ |s| s.overlaps?(shift) }.to_a
        (overlap_shifts.map{ |s1| overlap_shifts.select{ |s2| s1.overlaps?(s2) }.size }.max || 0) >= overlap
      end
    end
  end
end

