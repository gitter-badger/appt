module Appt
  class AppointmentType < ActiveRecord::Base
    alias_attribute :title, :name

    has_many :appointments, dependent: :destroy
    has_and_belongs_to_many :calendars, join_table: :appt_calendars_appointment_types

    validates :duration_minutes, :before_minutes, :after_minutes,
      presence: true, numericality: { greater_than_or_equal_to: 0 }

    def duration
      duration_minutes.try(:minutes)
    end

    def before
      before_minutes.try(:minutes)
    end

    def after
      after_minutes.try(:minutes)
    end
  end
end

