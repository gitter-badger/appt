module Appt
  class Appointment < CalendarEvent
    belongs_to :calendar, inverse_of: :appointments
    belongs_to :appointment_type

    validates :appointment_type, presence: true

    def title
      [
        "#{firstname} #{lastname}".strip,
        email,
        'Appointment',
      ].find{ |s| !s.blank? }
    end
  end
end

