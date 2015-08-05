module Appt
  Calendar.create!(
    name: 'Denver',
    timezone_name: 'Mountain Time (US & Canada)',
    availability_text: %{
      mon 10:00-18:00
      tue 10:00-18:00
      wed 10:00-18:00
      thu 10:00-18:00
      fri 10:00-18:00
      sat 12:00-16:00
    },
    resolution_minutes: 30,
    min_hours: 12,
    max_days: 180,
    lock_hours: 24,
  )
end

