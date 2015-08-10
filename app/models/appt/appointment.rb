module Appt
  class Appointment < CalendarEvent
    belongs_to :calendar, inverse_of: :appointments
    belongs_to :appointment_type
    delegate :duration, :before, :after, to: :appointment_type

    before_validation :set_end

    validates :appointment_type, :email, presence: true

    def available_shifts(&block)
      # TODO: nil checking?
      calendar.available_shifts(appointment_type, day, &block)
    end

    def full_name
      "#{firstname} #{lastname}".strip
    end

    def customer_title
      [
        full_name,
        email,
        'Customer',
      ].find{ |s| !s.blank? }
    end

    def display_shift
      start && self.end ? "#{start.strftime('%l:%M%P')} - #{self.end.strftime('%l:%M%P')}" : nil
    end

    def title
      [
        display_shift,
        'Appointment',
      ].find{ |s| !s.blank? }
    end

    def full_shift
      Tod::Shift.new(
        shift.beginning - before,
        shift.ending + after,
      )
    end

  private

    def set_end
      self.end = start + duration if start && duration
    end
  end
end

