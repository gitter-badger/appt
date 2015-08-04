module Appt
  class BaseController < Appt.parent_controller
    helper Appt::ApplicationHelper

    layout 'appt/application'
  end
end
