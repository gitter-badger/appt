module Appt
  class Calendar < ActiveRecord::Base
    serialize :availability, WorkhoursSerializer

    has_many :appointments, dependent: :destroy
    has_many :blocks, dependent: :destroy

    validates :timezone_name, presence: true, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name).freeze }
    validates :name, :availability, presence: true

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
  end
end

