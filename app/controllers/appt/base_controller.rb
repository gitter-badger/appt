module Appt
  class BaseController < Appt.parent_controller
    helper Appt::ApplicationHelper
    helper Appt::AppointmentHelpers
    helper Appt::CalendarEventHelpers

    layout 'appt/application'
  end
end

