require 'test_helper'

module Appt
  class IcalendarExpanderTest < ActionDispatch::IntegrationTest
    def setup
      @tz = ActiveSupport::TimeZone['America/Denver']
    end

    def assert_middle_events(events)
      last_event = nil
      events.each do |event|
        if last_event
          assert_equal Tod::TimeOfDay.parse('midnight'), last_event[:end]
          assert_equal Tod::TimeOfDay.parse('midnight'), event[:start]
        end

        last_event = event
      end
    end

    test 'handles singular event' do
      s = Date.new(2015, 8, 22)
      e = Date.new(2015, 8, 23)
      calendars = Icalendar.parse(File.read(File.expand_path('../../support/ics/singular.ics', __FILE__)))
      events = IcalendarExpander.new(@tz, calendars).events(s, e).to_a
      event = events.first

      assert_equal 1, events.size

      assert_equal 'singularid@google.com', event[:external_id]
      assert_equal 'Singular', event[:name]
      assert_equal Date.new(2015, 8, 22), event[:day]
      assert_equal Tod::TimeOfDay.parse('1700'), event[:start]
      assert_equal Tod::TimeOfDay.parse('2000'), event[:end]
    end

    test 'handles multi-day' do
      s = Date.new(2015, 8, 11)
      e = Date.new(2015, 8, 16)
      calendars = Icalendar.parse(File.read(File.expand_path('../../support/ics/multi-day.ics', __FILE__)))
      events = IcalendarExpander.new(@tz, calendars).events(s, e).to_a

      assert_equal 3, events.size
      assert_middle_events events

      events.each do |event|
        assert_equal 'multidayid@google.com', event[:external_id]
        assert_equal 'Multi-day', event[:name]
      end

      assert_equal Tod::TimeOfDay.parse('7:30'), events.first[:start]
      assert_equal Tod::TimeOfDay.parse('11:30'), events.last[:end]
    end

    test 'handles all-day' do
      s = Date.new(2016, 10, 19)
      e = Date.new(2016, 10, 24)
      calendars = Icalendar.parse(File.read(File.expand_path('../../support/ics/all-day.ics', __FILE__)))
      events = IcalendarExpander.new(@tz, calendars, include_transparent: true).events(s, e).to_a

      assert_equal 4, events.size
      assert_middle_events events

      events.each do |event|
        assert_equal 'alldayid@google.com', event[:external_id]
        assert_equal 'All day', event[:name]
      end

      assert_equal Tod::TimeOfDay.parse('midnight'), events.first[:start]
      assert_equal Tod::TimeOfDay.parse('midnight'), events.last[:end]
    end

    test 'handles recurrence' do
      s = Date.new(2015, 8, 5)
      e = Date.new(2015, 8, 13)
      calendars = Icalendar.parse(File.read(File.expand_path('../../support/ics/recurrence.ics', __FILE__)))
      events = IcalendarExpander.new(@tz, calendars).events(s, e).to_a

      assert_equal 2, events.size

      assert_equal [Date.new(2015, 8, 6), Date.new(2015, 8, 11)], events.map{ |event| event[:day] }

      events.each do |event|
        assert_equal 'recurringid@google.com', event[:external_id]
        assert_equal 'Recurring', event[:name]
        assert_equal Tod::TimeOfDay.parse('07:00'), event[:start]
        assert_equal Tod::TimeOfDay.parse('08:00'), event[:end]
      end
    end

    # test 'free/busy' do
    # end
  end
end

