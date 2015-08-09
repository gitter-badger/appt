module Appt
  class Appointment < CalendarEvent
    belongs_to :calendar, inverse_of: :appointments
    belongs_to :appointment_type

    before_validation :set_end

    validates :appointment_type, :email, presence: true

    def title
      [
        "#{firstname} #{lastname}".strip,
        email,
        'Appointment',
      ].find{ |s| !s.blank? }
    end

  private

    def set_end
      self.end = start + appointment_type.duration_minutes.minutes if appointment_type && start
    end
  end
end

