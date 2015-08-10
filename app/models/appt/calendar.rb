module Appt
  class Calendar < ActiveRecord::Base
    serialize :availability, WorkhoursSerializer

    has_many :appointments, dependent: :destroy
    has_many :blocks, dependent: :destroy
    has_many :external_calendars, ->{ distinct }, through: :blocks
    has_and_belongs_to_many :appointment_types, join_table: :appt_calendars_appointment_types

    validates :timezone_name, presence: true, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name).freeze }
    validates :name, :availability, presence: true
    validates :resolution_minutes, presence: true, inclusion: { in: [5, 10, 15, 20, 30, 60] }
    validates :allowed_overlap, presence: true, numericality: { greater_than_or_equal_to: 1 }

    def availability_text
      availability.try(:export).try(:[], :hours).try(:join, "\n")
    end

    def availability_text=(value)
      value ||= ''
      self.availability = Workhours::Week.new(hours: value.split("\n").reject(&:blank?).map(&:strip))
    end

    def timezone
      ActiveSupport::TimeZone[timezone_name]
    end

    def local_time_of_day(date, tod)
      date.at(tod, timezone)
    end

    def now
      timezone.now
    end

    def today
      now.to_date
    end

    def min_schedule_time
      now + min_hours.hours
    end

    def available_shifts(appointment_type, day = today, &block)
      # TODO: should before and after be counted in overlap?
      scheduler(appointment_type)
        .available_shifts(day, blocks.where(day: day).full_shifts, appointments.where(day: day).full_shifts, &block)
    end

    def title
      [
        name,
        'Calendar',
      ].find{ |s| !s.blank? }
    end

  protected

    def scheduler(appointment_type)
      Scheduler.new(
        availability,
        resolution: resolution_minutes.minutes,
        duration: appointment_type.duration_minutes.minutes,
        before: appointment_type.before_minutes.minutes,
        after: appointment_type.after_minutes.minutes,
        overlap: allowed_overlap,
      )
    end
  end
end

