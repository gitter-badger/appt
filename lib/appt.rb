require 'activemodel/associations'
require 'bootstrap_form'
require 'bootstrap-sass'
require 'faraday'
require 'haml-rails'
require 'icalendar'
require 'icalendar/recurrence'
require 'jquery-rails'
require 'kaminari'
require 'phony'
require 'phony_rails'
require 'rails_bootstrap_navbar'
require 'simple_calendar'
require 'tod'
require 'workhours'

require 'bootstrap_month_calendar'
require 'workhours_serializer'

require 'appt/engine'
require 'appt/configuration'
require 'appt/icalendar_expander'
require 'appt/scheduler'

module Appt
  extend Configuration
end

