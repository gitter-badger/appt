require 'test_helper'

module Appt
  class SchedulerTest < ActionDispatch::IntegrationTest
    def setup
      @week_text = %{
        mon 1:00-3:00
      }

      @week = Workhours::Week.new(hours: @week_text.split("\n").reject(&:blank?).map(&:strip))

      @scheduler = Scheduler.new(@week)
    end

    def monday
      Date.parse('Monday')
    end

    def shift(beginning, ending, exclude_end = true)
      Tod::Shift.new(Tod::TimeOfDay.parse(beginning), Tod::TimeOfDay.parse(ending), exclude_end)
    end

    test 'shifts, 30 duration, no before / after' do
      shifts = @scheduler.shifts(monday)

      assert_equal ['01:00:00', '01:30:00', '02:00:00', '02:30:00'], shifts.map{ |s| s.beginning.to_s }
    end

    test 'shifts, 30 duration, 15 before / 0 after' do
      @scheduler.before = 15.minutes

      shifts = @scheduler.shifts(monday)

      assert_equal ['01:30:00', '02:00:00', '02:30:00'], shifts.map{ |s| s.beginning.to_s }
    end

    test 'shifts, 30 duration, 0 before / 15 after' do
      @scheduler.after = 15.minutes

      shifts = @scheduler.shifts(monday)

      assert_equal ['01:00:00', '01:30:00', '02:00:00'], shifts.map{ |s| s.beginning.to_s }
    end

    test 'shifts, 30 duration, 75 before / 0 after' do
      @scheduler.before = 75.minutes

      shifts = @scheduler.shifts(monday)

      assert_equal ['02:30:00'], shifts.map{ |s| s.beginning.to_s }
    end

    test 'available_shifts, 30 duration, 0 before / after, no conflicts' do
      shifts = @scheduler.available_shifts(monday)

      assert_equal ['01:00:00', '01:30:00', '02:00:00', '02:30:00'], shifts.map{ |s| s.beginning.to_s }
    end

    test 'available_shifts, 30 duration, 0 before / after, w/ conflict' do
      shifts = @scheduler.available_shifts(monday, [shift('1:35', '2:15')])

      assert_equal ['01:00:00', '02:30:00'], shifts.map{ |s| s.beginning.to_s }
    end

    test 'exceeds_overlap, overlap 1' do
      candidate = shift('4:00', '5:00')

      assert @scheduler.send(:exceeds_overlap?, candidate, [shift('3:30', '4:30')])
      refute @scheduler.send(:exceeds_overlap?, candidate, [shift('5:15', '5:45')])
    end

    test 'exceeds_overlap, overlap 2, lined up' do
      @scheduler.overlap = 2

      candidate = shift('4:00', '5:00')

      assert @scheduler.send(:exceeds_overlap?, candidate, [shift('3:30', '4:30'), shift('3:30', '4:30')])
      refute @scheduler.send(:exceeds_overlap?, candidate, [shift('3:30', '4:30'), shift('4:30', '5:30')])
      refute @scheduler.send(:exceeds_overlap?, candidate, [shift('3:30', '4:30')])
      refute @scheduler.send(:exceeds_overlap?, candidate, [shift('5:15', '5:45')])
    end

    test 'exceeds_overlap, overlap 2, not lined up' do
      @scheduler.overlap = 2

      candidate = shift('4:00', '5:00')

      assert @scheduler.send(:exceeds_overlap?, candidate, [shift('3:30', '4:30'), shift('4:15', '4:45')])
      refute @scheduler.send(:exceeds_overlap?, candidate, [shift('3:30', '4:30'), shift('4:30', '5:30')])
      refute @scheduler.send(:exceeds_overlap?, candidate, [shift('3:30', '4:30')])
      refute @scheduler.send(:exceeds_overlap?, candidate, [shift('5:15', '5:45')])
    end
  end
end

